package tester

import (
	//"log"
	"sync"

	"6.5840/labrpc"
)

type Server struct {
	mu       sync.Mutex
	net      *labrpc.Network
	saved    *Persister
	svcs     []IService // list of services exported by
	endNames []string
	clntEnds []*labrpc.ClientEnd
}

func makeServer(net *labrpc.Network, gid Tgid, nsrv int) *Server {
	srv := &Server{net: net}
	srv.endNames = make([]string, nsrv)
	srv.clntEnds = make([]*labrpc.ClientEnd, nsrv)
	for j := 0; j < nsrv; j++ {
		// a fresh set of ClientEnds.
		srv.endNames[j] = Randstring(20)
		// a fresh set of ClientEnds.
		srv.clntEnds[j] = net.MakeEnd(srv.endNames[j])
		net.Connect(srv.endNames[j], ServerName(gid, j))
	}
	return srv
}

// If restart servers, first call ShutdownServer
func (s *Server) startServer(gid Tgid) *Server {
	srv := makeServer(s.net, gid, len(s.endNames))
	// a fresh persister, so old instance doesn't overwrite
	// new instance's persisted state.
	// give the fresh persister a copy of the old persister's
	// state, so that the spec is that we pass StartKVServer()
	// the last persisted state.
	if s.saved != nil {
		srv.saved = s.saved.Copy()
	} else {
		srv.saved = MakePersister()
	}
	return srv
}

// connect s to servers listed in to
func (s *Server) connect(sg *ServerGrp, to []int) {
	s.mu.Lock()
	defer s.mu.Unlock()
	for j := 0; j < len(to); j++ {
		if sg.IsConnected(to[j]) {
			//log.Printf("connect %d to %d (%v)", s.id, to[j], s.endNames[to[j]])
			endname := s.endNames[to[j]]
			s.net.Enable(endname, true)
		}
	}
}

func (s *Server) disconnect(from []int) {
	s.mu.Lock()
	defer s.mu.Unlock()

	if s.endNames == nil {
		return
	}
	for j := 0; j < len(from); j++ {
		endname := s.endNames[from[j]]
		s.net.Enable(endname, false)
	}
}

func (s *Server) shutdownServer() {
	s.mu.Lock()
	defer s.mu.Unlock()

	// a fresh persister, in case old instance
	// continues to update the Persister.
	// but copy old persister's content so that we always
	// pass Make() the last persisted state.
	if s.saved != nil {
		s.saved = s.saved.Copy()
	}

	// inform all services to stop
	for _, svc := range s.svcs {
		if svc != nil {
			svc.Kill()
		}
	}
	s.svcs = nil
}
