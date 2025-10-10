package tester

import (
	//"log"
	"sync"

	"6.5840/labrpc"
)

type end struct {
	name string
	end  *labrpc.ClientEnd
}

// Servers are named by ServerName() and clerks lazily make a
// per-clerk ClientEnd to a server.  Each clerk has a Clnt with a map
// of the allocated ends for this clerk.
type Clnt struct {
	mu   sync.Mutex
	net  *labrpc.Network
	ends map[string]end

	// if nil client can connect to all servers
	// if len(srvs) = 0, client cannot connect to any servers
	srvs []string
}

func makeClntTo(net *labrpc.Network, srvs []string) *Clnt {
	return &Clnt{ends: make(map[string]end), net: net, srvs: srvs}
}

// caller must acquire lock
func (clnt *Clnt) allowedL(server string) bool {
	if clnt.srvs == nil {
		return true
	}
	for _, n := range clnt.srvs {
		if n == server {
			return true
		}
	}
	return false
}

func (clnt *Clnt) makeEnd(server string) end {
	clnt.mu.Lock()
	defer clnt.mu.Unlock()

	if end, ok := clnt.ends[server]; ok {
		return end
	}

	name := Randstring(20)
	//log.Printf("%p: makEnd %v %v allowed %t", clnt, name, server, clnt.allowedL(server))
	end := end{name: name, end: clnt.net.MakeEnd(name)}
	clnt.net.Connect(name, server)
	if clnt.allowedL(server) {
		clnt.net.Enable(name, true)
	} else {
		clnt.net.Enable(name, false)
	}
	clnt.ends[server] = end
	return end
}

func (clnt *Clnt) Call(server, method string, args interface{}, reply interface{}) bool {
	end := clnt.makeEnd(server)
	ok := end.end.Call(method, args, reply)
	// log.Printf("%p: Call done e %v m %v %v %v ok %v", clnt, end.name, method, args, reply, ok)
	return ok
}

func (clnt *Clnt) ConnectAll() {
	clnt.mu.Lock()
	defer clnt.mu.Unlock()

	for _, e := range clnt.ends {
		//log.Printf("%p: ConnectAll: enable %v", clnt, e.name)
		clnt.net.Enable(e.name, true)
	}
	clnt.srvs = nil
}

func (clnt *Clnt) ConnectTo(srvs []string) {
	clnt.mu.Lock()
	defer clnt.mu.Unlock()

	// log.Printf("%p: ConnectTo: enable %v", clnt, srvs)
	clnt.srvs = srvs
	for srv, e := range clnt.ends {
		if clnt.allowedL(srv) {
			clnt.net.Enable(e.name, true)
		}
	}
}

func (clnt *Clnt) Disconnect(srv string) {
	clnt.mu.Lock()
	defer clnt.mu.Unlock()

	for s, e := range clnt.ends {
		if s == srv {
			//log.Printf("%p: Disconnect: disable %v %s", clnt, srv)
			clnt.net.Enable(e.name, false)
		}
	}
}

func (clnt *Clnt) DisconnectAll() {
	clnt.mu.Lock()
	defer clnt.mu.Unlock()

	for _, e := range clnt.ends {
		//log.Printf("%p: Disconnectall: disable %v", clnt, e.name)
		clnt.net.Enable(e.name, false)
	}
	clnt.srvs = make([]string, 0)
}

func (clnt *Clnt) remove() {
	clnt.mu.Lock()
	defer clnt.mu.Unlock()

	for _, e := range clnt.ends {
		clnt.net.DeleteEnd(e.name)
	}
}

type Clnts struct {
	mu     sync.Mutex
	net    *labrpc.Network
	clerks map[*Clnt]struct{}
}

func makeClnts(net *labrpc.Network) *Clnts {
	clnts := &Clnts{net: net, clerks: make(map[*Clnt]struct{})}
	return clnts
}

func (clnts *Clnts) makeEnd(servername string) *labrpc.ClientEnd {
	name := Randstring(20)
	end := clnts.net.MakeEnd(name)
	clnts.net.Connect(name, servername)
	clnts.net.Enable(name, true)
	return end
}

// Create a clnt for a clerk with specific server names, but allow
// only connections to connections to servers in to[].
func (clnts *Clnts) MakeClient() *Clnt {
	return clnts.MakeClientTo(nil)
}

func (clnts *Clnts) MakeClientTo(srvs []string) *Clnt {
	clnts.mu.Lock()
	defer clnts.mu.Unlock()
	clnt := makeClntTo(clnts.net, srvs)
	clnts.clerks[clnt] = struct{}{}
	return clnt
}

func (clnts *Clnts) cleanup() {
	clnts.mu.Lock()
	defer clnts.mu.Unlock()

	for clnt, _ := range clnts.clerks {
		clnt.remove()
	}
	clnts.clerks = nil
}

func (clnts *Clnts) DeleteClient(clnt *Clnt) {
	clnts.mu.Lock()
	defer clnts.mu.Unlock()

	if _, ok := clnts.clerks[clnt]; ok {
		clnt.remove()
		delete(clnts.clerks, clnt)
	}
}
