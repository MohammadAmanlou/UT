package shardkv

import (
	"log"
	"testing"
	"time"

	"6.5840/kvsrv1/rpc"
	"6.5840/kvtest1"
	"6.5840/shardkv1/shardcfg"
	"6.5840/shardkv1/shardctrler"
	"6.5840/shardkv1/shardctrler/param"
	"6.5840/tester1"
)

const (
	NGRP  = 8
	NKEYS = 5 * shardcfg.NShards
)

// Test shard controller's Init and Query with a key/value server from
// kvsrv1 lab.
func TestInitQuery5A(t *testing.T) {

	// MakeTest starts a key/value server using `kvsrv.StartKVServer`,
	// which is defined in shardkv1/kvsrv1.
	ts := MakeTest(t, "Test (5A): Init and Query ...", true)
	defer ts.Cleanup()

	// Make a shard controller
	sck := shardctrler.MakeShardCtrler(ts.Config.MakeClient(), ts.leases)

	// Make an empty shard configuration
	scfg := shardcfg.MakeShardConfig()

	// Compute a new shard configuration as if `shardcfg.Gid1` joins  the cluster,
	// assigning all shards to `shardcfg.Gid1`.
	scfg.JoinBalance(map[tester.Tgid][]string{shardcfg.Gid1: []string{"xxx"}})

	// Invoke the controller to initialize to store the first configuration
	sck.InitConfig(scfg)

	// Read the initial configuration and check it
	cfg, v := sck.Query()
	if v != 1 || cfg.Num != 1 || cfg.Shards[0] != shardcfg.Gid1 {
		ts.t.Fatalf("Static wrong %v %v", cfg, v)
	}
	cfg.CheckConfig(t, []tester.Tgid{shardcfg.Gid1})
}

// Test shardkv clerk's Get/Put with 1 shardgrp (without reconfiguration)
func TestStaticOneShardGroup5A(t *testing.T) {
	ts := MakeTest(t, "Test (5A): one shard group ...", true)
	defer ts.Cleanup()

	// The tester's setupKVService() sets up a kvsrv for the
	// controller to store configurations and calls the controller's
	// Init() method to create the first configuration with 1
	// shardgrp.
	ts.setupKVService()

	ck := ts.MakeClerk()               // make a shardkv clerk
	ka, va := ts.SpreadPuts(ck, NKEYS) // do some puts
	n := len(ka)
	for i := 0; i < n; i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1)) // check the puts
	}

	// disconnect raft leader of shardgrp and check that keys are
	// still avaialable
	ts.disconnectClntFromLeader(ck.(*kvtest.TestClerk).Clnt, shardcfg.Gid1)

	for i := 0; i < n; i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1)) // check the puts
	}
}

// test shardctrler's join, which adds a new group Gid2 and must move
// shards to the new group and the old group should reject Get/Puts on
// shards that moved.
func TestJoinBasic5A(t *testing.T) {
	ts := MakeTest(t, "Test (5A): a group joins...", true)
	defer ts.Cleanup()

	gid1 := ts.setupKVService()
	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)

	sck := ts.ShardCtrler()
	cfg, _ := sck.Query()

	gid2 := ts.newGid()
	err := ts.joinGroups(sck, []tester.Tgid{gid2})
	if err != rpc.OK {
		ts.t.Fatalf("joinGroups: err %v", err)
	}

	cfg1, _ := sck.Query()
	if cfg.Num+1 != cfg1.Num {
		ts.t.Fatalf("wrong num %d expected %d ", cfg1.Num, cfg.Num+1)
	}

	if !cfg1.IsMember(gid2) {
		ts.t.Fatalf("%d isn't a member of %v", gid2, cfg1)
	}

	ts.checkShutdownSharding(gid1, ka, va)

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}

	ts.checkShutdownSharding(gid2, ka, va)

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}
}

// test shardgrps delete moved shards
func TestDeleteBasic5A(t *testing.T) {
	const (
		MAXRAFTSTATE = 1000
		VALUESIZE    = 10000
	)

	ts := MakeTestMaxRaft(t, "Test (5A): delete ...", true, false, VALUESIZE)
	defer ts.Cleanup()

	gid1 := ts.setupKVService()
	ck := ts.MakeClerk()

	ka, va := ts.SpreadPutsSize(ck, NKEYS, MAXRAFTSTATE)

	sz := ts.Group(gid1).SnapshotSize()

	sck := ts.ShardCtrler()
	gid2 := ts.newGid()
	err := ts.joinGroups(sck, []tester.Tgid{gid2})
	if err != rpc.OK {
		ts.t.Fatalf("joinGroups: err %v", err)
	}

	// push more Get's through so that all peers snapshot
	for j := 0; j < 5; j++ {
		for i := 0; i < len(ka); i++ {
			ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
		}
	}
	sz1 := ts.Group(gid1).SnapshotSize()
	sz2 := ts.Group(gid2).SnapshotSize()
	if sz1+sz2 > sz+10000 {
		ts.t.Fatalf("gid1 %d + gid2 %d = %d use too much space %d", sz1, sz2, sz1+sz2, sz)
	}
}

// test shardctrler's leave
func TestJoinLeaveBasic5A(t *testing.T) {
	ts := MakeTest(t, "Test (5A): basic groups join/leave ...", true)
	defer ts.Cleanup()

	gid1 := ts.setupKVService()
	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)

	sck := ts.ShardCtrler()
	gid2 := ts.newGid()
	err := ts.joinGroups(sck, []tester.Tgid{gid2})
	if err != rpc.OK {
		ts.t.Fatalf("joinGroups: err %v", err)
	}

	ts.checkShutdownSharding(gid1, ka, va)

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}

	err = ts.leave(sck, shardcfg.Gid1)
	if err != rpc.OK {
		ts.t.Fatalf("Leave: err %v", err)
	}
	cfg, _ := sck.Query()
	if cfg.IsMember(shardcfg.Gid1) {
		ts.t.Fatalf("%d is a member of %v", shardcfg.Gid1, cfg)
	}

	ts.Group(shardcfg.Gid1).Shutdown()

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}

	// bring the crashed shard/group back to life.
	ts.Group(shardcfg.Gid1).StartServers()

	// Rejoin
	ts.join(sck, shardcfg.Gid1, ts.Group(shardcfg.Gid1).SrvNames())

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}

	ts.checkShutdownSharding(gid2, ka, va)
}

// test many groups joining and leaving, reliable or unreliable
func joinLeave5A(t *testing.T, reliable bool, part string) {
	ts := MakeTest(t, "Test (5A): many groups join/leave ...", reliable)
	defer ts.Cleanup()

	ts.setupKVService()
	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)

	sck := ts.ShardCtrler()
	grps := ts.groups(NGRP)

	ts.joinGroups(sck, grps)

	ts.checkShutdownSharding(grps[0], ka, va)

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}

	ts.leaveGroups(sck, grps)

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}
}

func TestManyJoinLeaveReliable5A(t *testing.T) {
	joinLeave5A(t, true, "Test (5A): many groups join/leave reliable...")
}

func TestManyJoinLeaveUnreliable5A(t *testing.T) {
	joinLeave5A(t, false, "Test (5A): many groups join/leave unreliable...")
}

// Test recovery from complete shutdown
func TestShutdown5A(t *testing.T) {
	const NJOIN = 2
	const NGRP = 2 + NJOIN

	ts := MakeTest(t, "Test (5A): shutdown ...", true)
	defer ts.Cleanup()

	ts.setupKVService()

	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)

	sck := ts.ShardCtrler()
	grps := ts.groups(NJOIN)
	ts.joinGroups(sck, grps)

	ts.checkShutdownSharding(grps[0], ka, va)

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}

	for i := shardcfg.Gid1; i < NGRP; i++ {
		ts.Group(i).Shutdown()
	}

	for i := shardcfg.Gid1; i < NGRP; i++ {
		ts.Group(i).StartServers()
	}

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}
}

// Test that Gets for keys at groups that are alive
// return
func TestProgressShutdown(t *testing.T) {
	const (
		NJOIN = 4
		NSEC  = 2
	)

	ts := MakeTest(t, "Test (5A): progress ...", true)
	defer ts.Cleanup()

	ts.setupKVService()

	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)

	sck := ts.ShardCtrler()
	grps := ts.groups(NJOIN)
	ts.joinGroups(sck, grps)

	end := 2
	for _, g := range grps[0:2] {
		//log.Printf("shutdown %d", g)
		ts.Group(g).Shutdown()
	}

	alive := make(map[tester.Tgid]bool)
	for _, g := range grps[end:] {
		alive[g] = true
	}

	cfg, _ := sck.Query()

	ch := make(chan rpc.Err)
	go func() {
		for i := 0; i < len(ka); i++ {
			s := shardcfg.Key2Shard(ka[i])
			g := cfg.Shards[s]
			if _, ok := alive[g]; ok {
				//log.Printf("key lookup %v(%d) gid %d", ka[i], s, g)
				ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
			}
		}
		ch <- rpc.OK
	}()

	select {
	case <-ch:
	case <-time.After(NSEC * time.Second):
		ts.Fatalf("Gets didn't finish")
	}
}

// Test that Gets from a non-moving shard return quickly
func TestProgressJoin(t *testing.T) {
	const (
		NJOIN = 4
		NSEC  = 4
		NCNT  = 100
	)

	ts := MakeTest(t, "Test (5A): progress ...", true)
	defer ts.Cleanup()

	ts.setupKVService()

	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)

	sck := ts.ShardCtrler()
	grps := ts.groups(NJOIN)
	ts.joinGroups(sck, grps)

	cfg, _ := sck.Query()
	newcfg := cfg.Copy()
	newgid := tester.Tgid(NJOIN + 3)
	if ok := newcfg.JoinBalance(map[tester.Tgid][]string{newgid: []string{"xxx"}}); !ok {
		t.Fatalf("JoinBalance failed")
	}
	newcfg1 := newcfg.Copy()
	if ok := newcfg1.LeaveBalance([]tester.Tgid{newgid}); !ok {
		t.Fatalf("JoinBalance failed")
	}

	// compute which shards don't move and which groups are involved
	// in moving shards
	stable := make(map[shardcfg.Tshid]bool)
	participating := make(map[tester.Tgid]bool)
	for i, g := range newcfg1.Shards {
		if newcfg.Shards[i] == g {
			stable[shardcfg.Tshid(i)] = true
		} else {
			participating[g] = true
		}
	}

	//log.Printf("groups participating %v stable %v", participating, stable)
	//log.Printf("\ncfg %v\n %v\n %v", cfg.Shards, newcfg.Shards, newcfg1.Shards)

	ch0 := make(chan rpc.Err)
	go func() {
		for true {
			select {
			case <-ch0:
				return
			default:
				//log.Printf("join/leave %v", newgid)
				if err := ts.joinGroups(sck, []tester.Tgid{newgid}); err != rpc.OK {
					t.Fatalf("joined err %v", err)
				}
				if err := ts.leaveGroups(sck, []tester.Tgid{newgid}); err != rpc.OK {
					t.Fatalf("leave err %v", err)
				}
			}
		}
	}()

	ch1 := make(chan int)
	go func() {
		// get the keys that are on groups that are involved in the
		// join but not in the shards that are moving
		t := time.Now().Add(NSEC * time.Second)
		nget := 0
		for time.Now().Before(t) {
			for i := 0; i < len(ka); i++ {
				s := shardcfg.Key2Shard(ka[i])
				if _, ok := stable[s]; ok {
					g := newcfg1.Shards[s]
					if _, ok := participating[g]; ok {
						// log.Printf("key lookup %v(%d) gid %d", ka[i], s, g)
						ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
						nget++
					}
				}
			}
		}
		ch1 <- nget
	}()

	select {
	case cnt := <-ch1:
		log.Printf("cnt %d", cnt)
		if cnt < NCNT {
			ts.Fatalf("Two few gets finished %d; expected more than %d", cnt, NCNT)
		}

	case <-time.After(2 * NSEC * time.Second):
		ts.Fatalf("Gets didn't finish")
	}
	ch0 <- rpc.OK
}

// Test linearizability with groups joining/leaving and `nclnt`
// concurrent clerks put/get's in `unreliable` net.
func concurrentClerk(t *testing.T, nclnt int, reliable bool, part string) {
	const (
		NSEC = 20
	)

	ts := MakeTest(t, part, reliable)
	defer ts.Cleanup()

	ts.setupKVService()

	ka := kvtest.MakeKeys(NKEYS)
	ch := make(chan []kvtest.ClntRes)

	go func(ch chan []kvtest.ClntRes) {
		rs := ts.SpawnClientsAndWait(nclnt, NSEC*time.Second, func(me int, ck kvtest.IKVClerk, done chan struct{}) kvtest.ClntRes {
			return ts.OneClientPut(me, ck, ka, done)
		})
		ch <- rs
	}(ch)

	sck := ts.ShardCtrler()
	grps := ts.groups(NGRP)
	if err := ts.joinGroups(sck, grps); err != rpc.OK {
		t.Fatalf("joinGroups err %v", err)
	}

	if err := ts.leaveGroups(sck, grps); err != rpc.OK {
		t.Fatalf("leaveGroups err %v", err)
	}

	<-ch

	ts.CheckPorcupine()
}

// Test linearizability with groups joining/leaving and 1 concurrent clerks put/get's
func TestOneConcurrentClerkReliable5A(t *testing.T) {
	concurrentClerk(t, 1, true, "Test (5A): one concurrent clerk reliable...")
}

// Test linearizability with groups joining/leaving and many concurrent clerks put/get's
func TestManyConcurrentClerkReliable5A(t *testing.T) {
	const NCLNT = 10
	concurrentClerk(t, NCLNT, true, "Test (5A): many concurrent clerks reliable...")
}

// Test linearizability with groups joining/leaving and 1 concurrent clerks put/get's
func TestOneConcurrentClerkUnreliable5A(t *testing.T) {
	concurrentClerk(t, 1, false, "Test (5A): one concurrent clerk unreliable ...")
}

// Test linearizability with groups joining/leaving and many concurrent clerks put/get's
func TestManyConcurrentClerkUnreliable5A(t *testing.T) {
	const NCLNT = 10
	concurrentClerk(t, NCLNT, false, "Test (5A): many concurrent clerks unreliable...")
}

// Test if join/leave complete even if shardgrp is down for a while, but
// don't complete while the shardgrp is down.
func TestJoinLeave5B(t *testing.T) {
	const NSEC = 2

	ts := MakeTest(t, "Test (5B): Join/leave while a shardgrp is down...", true)
	defer ts.Cleanup()

	gid1 := ts.setupKVService()
	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)

	sck := ts.ShardCtrler()
	cfg, _ := sck.Query()

	ts.Group(gid1).Shutdown()

	gid2 := ts.newGid()
	ch := make(chan rpc.Err)
	go func() {
		err := ts.joinGroups(sck, []tester.Tgid{gid2})
		ch <- err
	}()

	select {
	case err := <-ch:
		ts.Fatalf("Join finished %v", err)
	case <-time.After(1 * NSEC):
		// Give Join some time to try to join
	}

	// Now join should be able to finish
	ts.Group(gid1).StartServers()

	select {
	case err := <-ch:
		if err != rpc.OK {
			ts.Fatalf("Join returns err %v", err)
		}
	case <-time.After(time.Second * NSEC):
		ts.Fatalf("Join didn't complete")
	}

	cfg1, _ := sck.Query()
	if cfg.Num+1 != cfg1.Num {
		ts.t.Fatalf("wrong num %d expected %d ", cfg1.Num, cfg.Num+1)
	}

	ts.Group(gid2).Shutdown()

	ch = make(chan rpc.Err)
	go func() {
		err := ts.leave(sck, shardcfg.Gid1)
		ch <- err
	}()

	select {
	case err := <-ch:
		ts.Fatalf("Leave finished %v", err)
	case <-time.After(NSEC * time.Second):
		// Give give some time to try to join
	}

	// Now leave should be able to finish
	ts.Group(gid2).StartServers()

	select {
	case err := <-ch:
		if err != rpc.OK {
			ts.Fatalf("Leave returns err %v", err)
		}
	case <-time.After(time.Second * NSEC):
		ts.Fatalf("Leave didn't complete")
	}
	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}
}

// test recovery of partitioned controllers
func TestRecoverCtrler5B(t *testing.T) {
	const (
		NPARTITION = 5
	)

	ts := MakeTest(t, "Test (5B): recover controller ...", true)
	defer ts.Cleanup()

	gid := ts.setupKVService()
	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)

	for i := 0; i < NPARTITION; i++ {
		ts.killCtrler(ck, gid, ka, va)
	}
}

// Test concurrent ctrlers fighting for leadership reliable
func TestAcquireLockConcurrentReliable5C(t *testing.T) {
	ts := MakeTestLeases(t, "Test (5C): Concurent ctrlers acquiring leadership ...", true)
	defer ts.Cleanup()
	ts.setupKVService()
	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)
	ts.electCtrler(ck, ka, va)
}

// Test concurrent ctrlers fighting for leadership unreliable
func TestAcquireLockConcurrentUnreliable5C(t *testing.T) {
	ts := MakeTestLeases(t, "Test (5C): Concurent ctrlers acquiring leadership ...", false)
	defer ts.Cleanup()
	ts.setupKVService()
	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)
	ts.electCtrler(ck, ka, va)
}

// Test that ReleaseLock allows a new leader to start quickly
func TestLeaseBasicRelease5C(t *testing.T) {
	ts := MakeTestLeases(t, "Test (5C): release lease ...", true)
	defer ts.Cleanup()
	ts.setupKVService()

	sck0, clnt0 := ts.makeShardCtrlerClnt()
	go func() {
		if err := sck0.InitController(); err != rpc.OK {
			t.Fatalf("failed to init controller %v", err)
		}
		time.Sleep(200 * time.Millisecond)
		sck0.ExitController()
	}()

	time.Sleep(10 * time.Millisecond)

	// start new controller
	sck1, clnt1 := ts.makeShardCtrlerClnt()
	ch := make(chan struct{})
	go func() {
		if err := sck1.InitController(); err != rpc.OK {
			t.Fatalf("failed to init controller %v", err)
		}
		time.Sleep(200 * time.Millisecond)
		sck1.ExitController()
		ch <- struct{}{}
	}()

	select {
	case <-time.After(1 * time.Second):
		ts.Fatalf("Release didn't give up leadership")
	case <-ch:
	}

	ts.Config.DeleteClient(clnt0)
	ts.Config.DeleteClient(clnt1)
}

// Test lease expiring
func TestLeaseBasicExpire5C(t *testing.T) {
	ts := MakeTestLeases(t, "Test (5C): lease expiring ...", true)
	defer ts.Cleanup()
	ts.setupKVService()

	sck0, clnt0 := ts.makeShardCtrlerClnt()
	go func() {
		if err := sck0.InitController(); err != rpc.OK {
			t.Fatalf("failed to init controller %v", err)
		}
		for {
			time.Sleep(10 * time.Millisecond)
		}
	}()

	time.Sleep(100 * time.Millisecond)

	// partition sck0 forever
	clnt0.DisconnectAll()

	// start new controller
	sck1, clnt1 := ts.makeShardCtrlerClnt()
	ch := make(chan struct{})
	go func() {
		if err := sck1.InitController(); err != rpc.OK {
			t.Fatalf("failed to init controller %v", err)
		}
		time.Sleep(100 * time.Millisecond)
		sck1.ExitController()
		ch <- struct{}{}
	}()

	select {
	case <-time.After((param.LEASETIMESEC + 1) * time.Second):
		ts.Fatalf("Lease didn't expire")
	case <-ch:
	}

	ts.Config.DeleteClient(clnt0)
	ts.Config.DeleteClient(clnt1)
}

// Test lease is being extended
func TestLeaseBasicRefresh5C(t *testing.T) {
	const LEADERSEC = 3

	ts := MakeTestLeases(t, "Test (5C): lease refresh ...", true)
	defer ts.Cleanup()
	ts.setupKVService()

	sck0, clnt0 := ts.makeShardCtrlerClnt()
	go func() {
		if err := sck0.InitController(); err != rpc.OK {
			t.Fatalf("failed to init controller %v", err)
		}
		time.Sleep(LEADERSEC * param.LEASETIMESEC * time.Second)
		sck0.ExitController()
	}()

	// give sck0 time to become leader
	time.Sleep(100 * time.Millisecond)

	// start new controller
	sck1, clnt1 := ts.makeShardCtrlerClnt()
	ch := make(chan struct{})
	go func() {
		if err := sck1.InitController(); err != rpc.OK {
			t.Fatalf("failed to init controller %v", err)
		}
		time.Sleep(100 * time.Millisecond)
		sck1.ExitController()
		ch <- struct{}{}
	}()

	select {
	case <-time.After((LEADERSEC + param.LEASETIMESEC + 1) * time.Second):
	case <-ch:
		ts.Fatalf("Lease not refreshed")
	}

	ts.Config.DeleteClient(clnt0)
	ts.Config.DeleteClient(clnt1)
}

// Test if old leader is fenced off when reconnecting while it is in
// the middle of a Join.
func TestPartitionControllerJoin5C(t *testing.T) {
	const (
		NSLEEP = 2
		RAND   = 1000
	)

	ts := MakeTestLeases(t, "Test (5C): partition controller in join...", true)
	defer ts.Cleanup()
	ts.setupKVService()
	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)

	sck, clnt := ts.makeShardCtrlerClnt()
	if err := sck.InitController(); err != rpc.OK {
		ts.Fatalf("failed to init controller %v", err)
	}

	ch := make(chan rpc.Err)
	ngid := tester.Tgid(0)
	go func() {
		ngid = ts.newGid()
		ts.Config.MakeGroupStart(ngid, NSRV, ts.StartServerShardGrp)
		ts.Group(ngid).Shutdown()
		ch <- ts.join(sck, ngid, ts.Group(ngid).SrvNames())
	}()

	// sleep for a while to get the chance for the controller to get
	// stuck in join, because gid is down
	time.Sleep(1 * time.Second)

	// partition sck
	clnt.DisconnectAll()

	// wait until sck's lease expired before restarting shardgrp `ngid`
	time.Sleep((param.LEASETIMESEC + 1) * time.Second)

	ts.Group(ngid).StartServers()

	// start new controller to supersede partitioned one,
	sck0 := ts.makeShardCtrler()
	if err := sck0.InitController(); err != rpc.OK {
		t.Fatalf("failed to init controller %v", err)
	}

	scfg, _ := sck0.Query()
	if !scfg.IsMember(ngid) {
		t.Fatalf("Didn't recover gid %d", ngid)
	}

	sck0.ExitController()

	// reconnect old controller, which shouldn't finish ChangeConfigTo
	clnt.ConnectAll()

	err := <-ch
	if err == rpc.OK {
		t.Fatalf("Old leader succeeded %v", err)
	}

	time.Sleep(1 * time.Second)

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}
}

// Make a leader controller loses its leadership during join/leave and
// test if the next controller recovers correctly.
func TestPartitionRecovery5C(t *testing.T) {
	const (
		// NPARTITION = 10
		NPARTITION = 5
	)

	ts := MakeTestLeases(t, "Test (5C): controllers with leased leadership ...", true)
	defer ts.Cleanup()
	gid := ts.setupKVService()
	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)

	for i := 0; i < NPARTITION; i++ {
		ts.killCtrler(ck, gid, ka, va)
	}
}
