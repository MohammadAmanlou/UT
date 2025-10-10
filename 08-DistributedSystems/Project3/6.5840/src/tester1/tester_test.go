package tester_test

import (
	"testing"

	"6.5840/kvsrv1/rpc"
	"6.5840/labrpc"
	"6.5840/tester1"
)

type Server struct {
	n      rpc.Tversion
	killed bool
}

func newSrv() *Server {
	return &Server{}
}

func (s *Server) Kill() {
	s.killed = true
}

func (s *Server) Get(args *rpc.GetArgs, reply *rpc.GetReply) {
	s.n += 1
	reply.Version = s.n
}

type Test struct {
	t *testing.T
	s *Server
	*tester.Config
	clnt *tester.Clnt
	sn   string
}

func makeTest(t *testing.T, nsrv int) *Test {
	ts := &Test{t: t, sn: tester.ServerName(tester.GRP0, 0)}
	cfg := tester.MakeConfig(t, nsrv, true, ts.startServer)
	ts.Config = cfg
	ts.clnt = ts.Config.MakeClient()
	return ts
}

func (ts *Test) startServer(servers []*labrpc.ClientEnd, gid tester.Tgid, me int, persister *tester.Persister) []tester.IService {
	ts.s = newSrv()
	return []tester.IService{ts.s}
}

func (ts *Test) cleanup() {
	ts.Cleanup()
}

func (ts *Test) oneRPC() bool {
	args := rpc.GetArgs{"xxx"}
	var reply rpc.GetReply
	if ok := ts.clnt.Call(ts.sn, "Server.Get", &args, &reply); !ok {
		return false
	}
	if reply.Version != ts.s.n {
		ts.Fatalf("Wrong version")
	}
	return true
}

func TestBasic(t *testing.T) {
	ts := makeTest(t, 1)
	defer ts.cleanup()
	ts.oneRPC()
}

func TestShutdownServer(t *testing.T) {
	ts := makeTest(t, 1)
	defer ts.cleanup()

	ts.oneRPC()
	ts.Group(tester.GRP0).Shutdown()
	if !ts.s.killed {
		ts.Fatalf("Not killed")
	}
	if ok := ts.oneRPC(); ok {
		ts.Fatalf("RPC succeeded")
	}
}
