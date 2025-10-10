package shardkv

import (
	"fmt"
	"log"
	"math/rand"
	"sync"
	"sync/atomic"
	"testing"
	"time"

	"6.5840/kvraft1/rsm"
	"6.5840/kvsrv1"
	"6.5840/kvsrv1/rpc"
	"6.5840/kvtest1"
	"6.5840/labrpc"
	"6.5840/shardkv1/shardcfg"
	"6.5840/shardkv1/shardctrler"
	"6.5840/shardkv1/shardgrp"
	"6.5840/tester1"
)

type Test struct {
	t *testing.T
	*kvtest.Test

	sck       *shardctrler.ShardCtrler
	part      string
	partition bool

	maxraftstate int
	mu           sync.Mutex
	ngid         tester.Tgid
}

const (
	Controler     = tester.Tgid(0) // controler uses group 0 for a kvraft group
	NSRV          = 3              // servers per group
	INTERGRPDELAY = 200            // time in ms between group changes
)

// Setup kvserver for the shard controller and make the controller
func MakeTestMaxRaft(t *testing.T, part string, reliable, partition bool, maxraftstate int) *Test {
	ts := &Test{
		ngid:         shardcfg.Gid1 + 1, // Gid1 is in use
		t:            t,
		partition:    partition,
		maxraftstate: maxraftstate,
	}
	cfg := tester.MakeConfig(t, 1, reliable, kvsrv.StartKVServer)
	ts.Test = kvtest.MakeTest(t, cfg, false, ts)
	// XXX to avoid panic
	tester.AnnotateTest(part, 1)
	ts.Begin(part)
	return ts
}

func MakeTest(t *testing.T, part string, reliable bool) *Test {
	return MakeTestMaxRaft(t, part, reliable, false, -1)
}

func MakeTestLeases(t *testing.T, part string, reliable bool) *Test {
	return MakeTestMaxRaft(t, part, reliable, true, -1)
}

func (ts *Test) MakeClerk() kvtest.IKVClerk {
	clnt := ts.Config.MakeClient()
	ck := MakeClerk(clnt, ts.makeShardCtrler())
	return &kvtest.TestClerk{ck, clnt}
}

func (ts *Test) DeleteClerk(ck kvtest.IKVClerk) {
	tck := ck.(*kvtest.TestClerk)
	ts.DeleteClient(tck.Clnt)
}

func (ts *Test) ShardCtrler() *shardctrler.ShardCtrler {
	return ts.sck
}

func (ts *Test) makeShardCtrler() *shardctrler.ShardCtrler {
	ck, _ := ts.makeShardCtrlerClnt()
	return ck
}

func (ts *Test) makeShardCtrlerClnt() (*shardctrler.ShardCtrler, *tester.Clnt) {
	clnt := ts.Config.MakeClient()
	return shardctrler.MakeShardCtrler(clnt), clnt
}

func (ts *Test) makeKVClerk() *kvsrv.Clerk {
	srv := tester.ServerName(tester.GRP0, 0)
	clnt := ts.Config.MakeClient()
	return kvsrv.MakeClerk(clnt, srv).(*kvsrv.Clerk)
}

func (ts *Test) newGid() tester.Tgid {
	ts.mu.Lock()
	defer ts.mu.Unlock()

	gid := ts.ngid
	ts.ngid += 1
	return gid
}

func (ts *Test) groups(n int) []tester.Tgid {
	grps := make([]tester.Tgid, n)
	for i := 0; i < n; i++ {
		grps[i] = ts.newGid()
	}
	return grps
}

// Set up KVServervice with one group Gid1. Gid1 should initialize itself to
// own all shards.
func (ts *Test) setupKVService() tester.Tgid {
	ts.sck = ts.makeShardCtrler()
	scfg := shardcfg.MakeShardConfig()
	ts.Config.MakeGroupStart(shardcfg.Gid1, NSRV, ts.StartServerShardGrp)
	scfg.JoinBalance(map[tester.Tgid][]string{shardcfg.Gid1: ts.Group(shardcfg.Gid1).SrvNames()})
	ts.sck.InitConfig(scfg)
	return shardcfg.Gid1
}

func (ts *Test) StartServerShardGrp(servers []*labrpc.ClientEnd, gid tester.Tgid, me int, persister *tester.Persister) []tester.IService {
	return shardgrp.StartServerShardGrp(servers, gid, me, persister, ts.maxraftstate)
}

func (ts *Test) checkMember(sck *shardctrler.ShardCtrler, gid tester.Tgid) bool {
	cfg := sck.Query()
	ok := cfg.IsMember(gid)
	return ok
}

// Add group gid
func (ts *Test) join(sck *shardctrler.ShardCtrler, gid tester.Tgid, srvs []string) {
	cfg := sck.Query()
	newcfg := cfg.Copy()
	ok := newcfg.JoinBalance(map[tester.Tgid][]string{gid: srvs})
	if !ok {
		log.Fatalf("join: group %d is already present", gid)
	}
	sck.ChangeConfigTo(newcfg)
}

func (ts *Test) joinGroups(sck *shardctrler.ShardCtrler, gids []tester.Tgid) bool {
	for _, gid := range gids {
		ts.Config.MakeGroupStart(gid, NSRV, ts.StartServerShardGrp)
		ts.join(sck, gid, ts.Group(gid).SrvNames())
		if ok := ts.checkMember(sck, gid); !ok {
			return false
		}
		time.Sleep(INTERGRPDELAY * time.Millisecond)
	}
	return true
}

// Group gid leaves.
func (ts *Test) leave(sck *shardctrler.ShardCtrler, gid tester.Tgid) {
	cfg := sck.Query()
	newcfg := cfg.Copy()
	ok := newcfg.LeaveBalance([]tester.Tgid{gid})
	if !ok {
		log.Fatalf("leave: group %d is already not present", gid)
	}
	sck.ChangeConfigTo(newcfg)
}

func (ts *Test) leaveGroups(sck *shardctrler.ShardCtrler, gids []tester.Tgid) bool {
	for _, gid := range gids {
		ts.leave(sck, gid)
		if ok := ts.checkMember(sck, gid); ok {
			return false
		}
		ts.Config.ExitGroup(gid)
		time.Sleep(INTERGRPDELAY * time.Millisecond)
	}
	return true
}

func (ts *Test) disconnectClntFromLeader(gid tester.Tgid) int {
	ok, l := rsm.Leader(ts.Config, gid)
	if !ok {
		log.Fatalf("Leader failed")
	}
	ts.Group(gid).ShutdownServer(l)
	return l
}

// make sure that the data really is sharded by
// shutting down one shard and checking that some
// Get()s don't succeed.
func (ts *Test) checkShutdownSharding(down tester.Tgid, ka []string, va []string) {
	const NSEC = 2

	ts.Group(down).Shutdown()

	n := len(ka)
	ch := make(chan string)
	done := int32(0)
	for xi := 0; xi < n; xi++ {
		ck1 := ts.MakeClerk()
		go func(i int) {
			v, _, _ := ck1.Get(ka[i])
			if atomic.LoadInt32(&done) == 1 {
				return
			}
			if v != va[i] {
				ch <- fmt.Sprintf("Get(%v): expected:\n%v\nreceived:\n%v", ka[i], va[i], v)
			} else {
				ch <- ""
			}
		}(xi)
	}

	ndone := 0
	for atomic.LoadInt32(&done) != 1 {
		select {
		case err := <-ch:
			if err != "" {
				ts.Fatalf(err)
			}
			ndone += 1
		case <-time.After(time.Second * NSEC):
			atomic.StoreInt32(&done, 1)
			break
		}
	}

	// log.Printf("%d completions out of %d; down %d", ndone, n, down)
	if ndone >= n {
		ts.Fatalf("expected less than %d completions with shard %d down\n", n, down)
	}

	// bring the crashed shard/group back to life.
	ts.Group(down).StartServers()
}

// Run one controler and then partition it after some time. Run
// another cntrler that must finish the first ctrler's unfinished
// shard moves. To make it likely that first ctrler is in a join/leave
// the test shuts down shardgrp `gid`.  After the second controller is
// done, heal the partition.  partitionCtrler returns if recovery
// happened.
func (ts *Test) partitionCtrler(ck kvtest.IKVClerk, gid tester.Tgid, ka, va []string) {
	const (
		RAND = 400
		NSEC = 1

		JOIN  = 1
		LEAVE = 2
	)

	sck, clnt := ts.makeShardCtrlerClnt()
	sck.InitController()

	cfg := ts.ShardCtrler().Query()
	num := cfg.Num

	state := 0
	ngid := tester.Tgid(0)
	go func() {
		for {
			ngid = ts.newGid()
			state = JOIN
			ts.joinGroups(sck, []tester.Tgid{ngid})
			if ok := ts.checkMember(sck, ngid); ok {
				state = LEAVE
				ts.leaveGroups(sck, []tester.Tgid{ngid})
			} else {
				//log.Printf("%v: deposed", sck.Id())
				return
			}
		}
	}()

	// let sck run for a little while
	time.Sleep(1000 * time.Millisecond)

	r := rand.Int() % RAND
	d := time.Duration(r) * time.Millisecond
	time.Sleep(d)

	//log.Printf("shutdown gid %d after %dms %v", gid, r, time.Now().Sub(t))

	ts.Group(gid).Shutdown()

	// sleep for a while to get sck stuck in join or leave, because
	// gid is down
	time.Sleep(1000 * time.Millisecond)

	//log.Printf("disconnect sck %v ngid %d num %d state %d", d, ngid, num, state)

	// partition controller
	clnt.DisconnectAll()

	if ts.partition {
		// wait a while before restarting shardgrp `gid`
		time.Sleep(NSEC * time.Second)
	}

	//log.Printf("startservers %v lease expired %t", time.Now().Sub(t), ts.leases)

	ts.Group(gid).StartServers()

	// start new controler to pick up where sck left off
	sck0, clnt0 := ts.makeShardCtrlerClnt()

	sck0.InitController()
	cfg = sck0.Query()
	s := "join"
	if state == LEAVE {
		s = "leave"
	}

	if cfg.Num <= num {
		ts.Fatalf("didn't recover; expected %d > %d", num, cfg.Num)
	}

	//log.Printf("%v: recovered %v %v %v", sck0.Id(), time.Now().Sub(t), s, cfg)

	present := cfg.IsMember(ngid)
	if (state == JOIN && !present) || (state == LEAVE && present) {
		ts.Fatalf("didn't recover %d correctly after %v", ngid, s)
	}

	if state == JOIN && present {
		// cleanup if disconnected after join but before leave
		ts.leaveGroups(sck0, []tester.Tgid{ngid})
	}

	if ts.partition {
		// reconnect old controller, which should bail out, because
		// it has been superseded.
		clnt.ConnectAll()

		time.Sleep(100 * time.Millisecond)

	}

	//log.Printf("reconnected %v", time.Now().Sub(t))

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}

	//log.Printf("done get %v", time.Now().Sub(t))

	ts.Config.DeleteClient(clnt)
	ts.Config.DeleteClient(clnt0)
}

func (ts *Test) concurCtrler(ck kvtest.IKVClerk, ka, va []string) {
	const (
		NSEC = 2
		N    = 4
	)

	ch := make(chan struct{})
	f := func(ch chan struct{}, i int) {
		for true {
			select {
			case <-ch:
				return
			default:
				ngid := ts.newGid()
				sck := ts.makeShardCtrler()
				sck.InitController()
				//log.Printf("%v: electCtrler %d join/leave %v", sck.Id(), i, ngid)
				ts.joinGroups(sck, []tester.Tgid{ngid})
				if ok := ts.checkMember(sck, ngid); ok {
					//log.Printf("%v: electCtrler %d leave %d", sck.Id(), i, ngid)
					if ok := ts.leaveGroups(sck, []tester.Tgid{ngid}); !ok {
						//log.Printf("%v: electCtrler %d leave %v failed", sck.Id(), i, ngid)
					}
				} else {
					//log.Printf("%v: electCtrler %d join %v failed", sck.Id(), i, ngid)
				}
			}
		}
	}
	for i := 0; i < N; i++ {
		go f(ch, i)
	}

	// let f()'s run for a while
	time.Sleep(NSEC * time.Second)

	for i := 0; i < N; i++ {
		ch <- struct{}{}
	}

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}

}
