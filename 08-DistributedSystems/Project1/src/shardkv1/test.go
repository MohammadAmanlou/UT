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
	"6.5840/kvsrv1/rpc"
	"6.5840/kvtest1"
	"6.5840/labrpc"
	"6.5840/shardkv1/kvsrv1"
	"6.5840/shardkv1/shardcfg"
	"6.5840/shardkv1/shardctrler"
	"6.5840/shardkv1/shardctrler/param"
	"6.5840/shardkv1/shardgrp"
	"6.5840/tester1"
)

type Test struct {
	t *testing.T
	*kvtest.Test

	sck    *shardctrler.ShardCtrler
	part   string
	leases bool

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
func MakeTestMaxRaft(t *testing.T, part string, reliable, leases bool, maxraftstate int) *Test {
	ts := &Test{
		ngid:         shardcfg.Gid1 + 1, // Gid1 is in use
		t:            t,
		leases:       leases,
		maxraftstate: maxraftstate,
	}
	cfg := tester.MakeConfig(t, 1, reliable, kvsrv.StartKVServer)
	ts.Test = kvtest.MakeTest(t, cfg, false, ts)
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
	return shardctrler.MakeShardCtrler(clnt, ts.leases), clnt
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

// Add group gid
func (ts *Test) join(sck *shardctrler.ShardCtrler, gid tester.Tgid, srvs []string) rpc.Err {
	cfg, _ := sck.Query()
	newcfg := cfg.Copy()
	ok := newcfg.JoinBalance(map[tester.Tgid][]string{gid: srvs})
	if !ok {
		log.Fatalf("join: group %d is already present", gid)
	}
	return sck.ChangeConfigTo(newcfg)
}

func (ts *Test) joinGroups(sck *shardctrler.ShardCtrler, gids []tester.Tgid) rpc.Err {
	for _, gid := range gids {
		ts.Config.MakeGroupStart(gid, NSRV, ts.StartServerShardGrp)
		if err := ts.join(sck, gid, ts.Group(gid).SrvNames()); err != rpc.OK {
			return err
		}
		time.Sleep(INTERGRPDELAY * time.Millisecond)
	}
	return rpc.OK
}

// Group gid leaves.
func (ts *Test) leave(sck *shardctrler.ShardCtrler, gid tester.Tgid) rpc.Err {
	cfg, _ := sck.Query()
	newcfg := cfg.Copy()
	ok := newcfg.LeaveBalance([]tester.Tgid{gid})
	if !ok {
		log.Fatalf("leave: group %d is already not present", gid)
	}
	return sck.ChangeConfigTo(newcfg)
}

func (ts *Test) leaveGroups(sck *shardctrler.ShardCtrler, gids []tester.Tgid) rpc.Err {
	for _, gid := range gids {
		if err := ts.leave(sck, gid); err != rpc.OK {
			return err
		}
		ts.Config.ExitGroup(gid)
		time.Sleep(INTERGRPDELAY * time.Millisecond)
	}
	return rpc.OK
}

func (ts *Test) disconnectRaftLeader(gid tester.Tgid) (int, string) {
	_, l := rsm.Leader(ts.Config, gid)
	g := ts.Group(gid)
	ln := g.SrvName(l)
	g.DisconnectAll(l)
	return l, ln
}

func (ts *Test) reconnectOldLeader(gid tester.Tgid, l int) {
	g := ts.Group(gid)
	g.ConnectOne(l)
}

func (ts *Test) disconnectClntFromLeader(clnt *tester.Clnt, gid tester.Tgid) int {
	l, ln := ts.disconnectRaftLeader(gid)
	p := ts.Group(gid).AllowServersExcept(l)
	srvs := ts.Group(gid).SrvNamesTo(p)
	clnt.Disconnect(ln)
	clnt.ConnectTo(srvs)
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
// shard moves. To ensure first ctrler is in a join/leave the test
// shuts down shardgrp `gid`.  After the second controller is done,
// heal the partition to test if Freeze,InstallShard, and Delete are
// are fenced.
func (ts *Test) killCtrler(ck kvtest.IKVClerk, gid tester.Tgid, ka, va []string) {
	const (
		NSLEEP = 2

		RAND = 1000

		JOIN  = 1
		LEAVE = 2
	)

	sck, clnt := ts.makeShardCtrlerClnt()
	if err := sck.InitController(); err != rpc.OK {
		ts.Fatalf("failed to init controller %v", err)
	}

	cfg, _ := ts.ShardCtrler().Query()
	num := cfg.Num

	state := 0
	ngid := tester.Tgid(0)
	go func() {
		for {
			ngid = ts.newGid()
			state = JOIN
			err := ts.joinGroups(sck, []tester.Tgid{ngid})
			if err == rpc.OK {
				state = LEAVE
				err = ts.leaveGroups(sck, []tester.Tgid{ngid})
			} else {
				//log.Printf("deposed err %v", err)
				return
			}
		}
	}()

	r := rand.Int() % RAND
	d := time.Duration(r) * time.Millisecond
	time.Sleep(d)

	//log.Printf("shutdown gid %d after %dms", gid, r)
	ts.Group(gid).Shutdown()

	// sleep for a while to get the chance for the controler to get stuck
	// in join or leave, because gid is down
	time.Sleep(NSLEEP * time.Second)

	//log.Printf("disconnect sck %v ngid %d num %d state %d", d, ngid, num, state)

	// partition controller
	clnt.DisconnectAll()

	if ts.leases {
		// wait until sck's lease expired before restarting shardgrp `gid`
		time.Sleep((param.LEASETIMESEC + 1) * time.Second)
	}

	ts.Group(gid).StartServers()

	// start new controler to pick up where sck left off
	sck0, clnt0 := ts.makeShardCtrlerClnt()
	if err := sck0.InitController(); err != rpc.OK {
		ts.Fatalf("failed to init controller %v", err)
	}
	cfg, _ = sck0.Query()
	s := "join"
	if state == LEAVE {
		s = "leave"
	}
	//log.Printf("%v cfg %v recovered %s", s, cfg, s)

	if cfg.Num <= num {
		ts.Fatalf("didn't recover; expected %d > %d", num, cfg.Num)
	}

	present := cfg.IsMember(ngid)
	if (state == JOIN && !present) || (state == LEAVE && present) {
		ts.Fatalf("didn't recover %d correctly after %v", ngid, s)
	}

	if state == JOIN && present {
		// cleanup if disconnected after join but before leave
		ts.leaveGroups(sck0, []tester.Tgid{ngid})
	}

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}

	sck0.ExitController()

	if ts.leases {
		// reconnect old controller, which should bail out, because
		// it has been superseded.
		clnt.ConnectAll()

		time.Sleep(1 * time.Second)

		for i := 0; i < len(ka); i++ {
			ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
		}
	}
	ts.Config.DeleteClient(clnt)
	ts.Config.DeleteClient(clnt0)
}

func (ts *Test) electCtrler(ck kvtest.IKVClerk, ka, va []string) {
	const (
		NSEC = 5
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
				if err := sck.InitController(); err != rpc.OK {
					ts.Fatalf("failed to init controller %v", err)
				}
				//log.Printf("%d(%p): join/leave %v", i, sck, ngid)
				if err := ts.joinGroups(sck, []tester.Tgid{ngid}); err == rpc.OK {
					ts.leaveGroups(sck, []tester.Tgid{ngid})
				}
				sck.ExitController()
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
