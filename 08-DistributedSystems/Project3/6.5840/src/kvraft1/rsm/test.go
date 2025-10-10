package rsm

import (
	//"log"
	"sync"
	"testing"
	"time"
	"fmt"

	"6.5840/kvsrv1/rpc"
	"6.5840/labrpc"
	"6.5840/raftapi"
	"6.5840/tester1"
)

type Test struct {
	*tester.Config
	mu           sync.Mutex
	t            *testing.T
	g            *tester.ServerGrp
	maxraftstate int
	srvs         []*rsmSrv
	leader       int
}

const (
	NSRV = 3
	NSEC = 10

	Gid = tester.GRP0
)

func makeTest(t *testing.T, maxraftstate int) *Test {
	ts := &Test{
		t:            t,
		maxraftstate: maxraftstate,
		srvs:         make([]*rsmSrv, NSRV),
	}
	ts.Config = tester.MakeConfig(t, NSRV, true, ts.mksrv)
	ts.g = ts.Group(tester.GRP0)
	return ts
}

func (ts *Test) cleanup() {
	ts.End()
	ts.Config.Cleanup()
	ts.CheckTimeout()
}

func (ts *Test) mksrv(ends []*labrpc.ClientEnd, grp tester.Tgid, srv int, persister *tester.Persister) []tester.IService {
	s := makeRsmSrv(ts, srv, ends, persister, false)
	ts.srvs[srv] = s
	return []tester.IService{s.rsm.Raft()}
}

func inPartition(s int, p []int) bool {
	if p == nil {
		return true
	}
	for _, i := range p {
		if s == i {
			return true
		}
	}
	return false
}

func (ts *Test) onePartition(p []int, req any) any {
	// try all the servers, maybe one is the leader but give up after NSEC
	t0 := time.Now()
	for time.Since(t0).Seconds() < NSEC {
		ts.mu.Lock()
		index := ts.leader
		ts.mu.Unlock()
		for range ts.srvs {
			if ts.g.IsConnected(index) {
				s := ts.srvs[index]
				if s.rsm != nil && inPartition(index, p) {
					err, rep := s.rsm.Submit(req)
					if err == rpc.OK {
						ts.mu.Lock()
						ts.leader = index
						ts.mu.Unlock()
						//log.Printf("leader = %d", ts.leader)
						return rep
					}
				}
			}
			index = (index + 1) % len(ts.srvs)
		}
		time.Sleep(50 * time.Millisecond)
		//log.Printf("try again: no leader")
	}
	return nil
}

func (ts *Test) oneInc() *IncRep {
	rep := ts.onePartition(nil, Inc{})
	if rep == nil {
		return nil
	}
	return rep.(*IncRep)
}

func (ts *Test) oneNull() *NullRep {
	rep := ts.onePartition(nil, Null{})
	if rep == nil {
		return nil
	}
	return rep.(*NullRep)
}

func (ts *Test) checkCounter(v int, nsrv int) {
	to := 10 * time.Millisecond
	n := 0
	for iters := 0; iters < 30; iters++ {
		n = ts.countValue(v)
		if n >= nsrv {
			text := fmt.Sprintf("all %v servers have counter value %v", nsrv, v)
			tester.AnnotateCheckerSuccess(text, text)
			return
		}
		time.Sleep(to)
		if to < time.Second {
			to *= 2
		}
	}
	err := fmt.Sprintf("checkCounter: only %d srvs have %v instead of %d", n, v, nsrv)
	tester.AnnotateCheckerFailure(err, err)
	ts.Fatalf(err)
}

func (ts *Test) countValue(v int) int {
	i := 0
	for _, s := range ts.srvs {
		s.mu.Lock()
		if s.counter == v {
			i += 1
		}
		s.mu.Unlock()
	}
	return i
}

func (ts *Test) disconnectLeader() int {
	//log.Printf("disconnect %d", ts.leader)
	ts.g.DisconnectAll(ts.leader)
	return ts.leader
}

func (ts *Test) connect(i int) {
	//log.Printf("connect %d", i)
	ts.g.ConnectOne(i)
}

func Leader(cfg *tester.Config, gid tester.Tgid) (bool, int) {
	for i, ss := range cfg.Group(gid).Services() {
		for _, s := range ss {
			switch r := s.(type) {
			case raftapi.Raft:
				_, isLeader := r.GetState()
				if isLeader {
					return true, i
				}
			default:
			}
		}
	}
	return false, 0
}
