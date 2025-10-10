package shardkv

import (
	//"log"
	"testing"
	"time"

	"6.5840/kvsrv1/rpc"
	"6.5840/kvtest1"
	"6.5840/shardkv1/shardcfg"
	"6.5840/shardkv1/shardctrler"
	"6.5840/tester1"
)

const (
	NGRP  = 8
	NKEYS = 5 * shardcfg.NShards
)

// Test shard controller's Init and Query with a key/value server from
// kvsrv1 lab.
func TestInitQuery5A(t *testing.T) {

	// MakeTest starts your lab2 key/value server using
	// `kvsrv.StartKVServer`.
	ts := MakeTest(t, "Test (5A): Init and Query ...", true)
	defer ts.Cleanup()

	// Make a shard controller
	sck := shardctrler.MakeShardCtrler(ts.Config.MakeClient())

	// Make an empty shard configuration
	scfg := shardcfg.MakeShardConfig()

	// Compute a new shard configuration as if `shardcfg.Gid1` joins  the cluster,
	// assigning all shards to `shardcfg.Gid1`.
	scfg.JoinBalance(map[tester.Tgid][]string{shardcfg.Gid1: []string{"xxx"}})

	// Invoke the controller to initialize to store the first configuration
	sck.InitConfig(scfg)

	// Read the initial configuration and check it
	cfg := sck.Query()
	if cfg.Num != 1 || cfg.Shards[0] != shardcfg.Gid1 {
		ts.t.Fatalf("Static wrong %v", cfg)
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
	// still available
	ts.disconnectClntFromLeader(shardcfg.Gid1)

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
	cfg := sck.Query()

	gid2 := ts.newGid()
	if ok := ts.joinGroups(sck, []tester.Tgid{gid2}); !ok {
		ts.t.Fatalf("TestJoinBasic5A: joinGroups failed")
	}

	cfg1 := sck.Query()
	if cfg.Num+1 != cfg1.Num {
		ts.t.Fatalf("TestJoinBasic5A: wrong num %d expected %d ", cfg1.Num, cfg.Num+1)
	}

	if !cfg1.IsMember(gid2) {
		ts.t.Fatalf("TestJoinBasic5A: %d isn't a member of %v", gid2, cfg1)
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
	if ok := ts.joinGroups(sck, []tester.Tgid{gid2}); !ok {
		ts.t.Fatalf("TestDeleteBasic5A: joinGroups failed")
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
		ts.t.Fatalf("TestDeleteBasic5A: gid1 %d + gid2 %d = %d use too much space %d", sz1, sz2, sz1+sz2, sz)
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
	if ok := ts.joinGroups(sck, []tester.Tgid{gid2}); !ok {
		ts.t.Fatalf("TestJoinLeaveBasic5A: joinGroups failed")
	}

	ts.checkShutdownSharding(gid1, ka, va)

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}

	ts.leave(sck, shardcfg.Gid1)
	if ok := ts.checkMember(sck, shardcfg.Gid1); ok {
		ts.t.Fatalf("%d is a member after leave", shardcfg.Gid1)
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
func TestProgressShutdown5A(t *testing.T) {
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

	cfg := sck.Query()

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
func TestProgressJoin5A(t *testing.T) {
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

	cfg := sck.Query()
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
				if ok := ts.joinGroups(sck, []tester.Tgid{newgid}); !ok {
					t.Fatalf("TestProgressJoin: join failed")
				}
				if ok := ts.leaveGroups(sck, []tester.Tgid{newgid}); !ok {
					t.Fatalf("TestProgressJoin: leave failed")
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
		//log.Printf("cnt %d", cnt)
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
	if ok := ts.joinGroups(sck, grps); !ok {
		t.Fatalf("concurrentClerk: joinGroups failed")
	}

	if ok := ts.leaveGroups(sck, grps); !ok {
		t.Fatalf("concurrentClerk: leaveGroups failed")
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
	cfg := sck.Query()

	ts.Group(gid1).Shutdown()

	gid2 := ts.newGid()
	ch := make(chan bool)
	go func() {
		ch <- ts.joinGroups(sck, []tester.Tgid{gid2})
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
	case ok := <-ch:
		if !ok {
			ts.Fatalf("TestJoinLeave5B: Join returned %t", ok)
		}
	case <-time.After(time.Second * NSEC):
		ts.Fatalf("Join didn't complete")
	}

	cfg1 := sck.Query()
	if cfg.Num+1 != cfg1.Num {
		ts.t.Fatalf("wrong num %d expected %d ", cfg1.Num, cfg.Num+1)
	}

	ts.Group(gid2).Shutdown()

	go func() {
		ch <- ts.leaveGroups(sck, []tester.Tgid{shardcfg.Gid1})
	}()

	select {
	case <-ch:
		ts.Fatalf("Leave finished")
	case <-time.After(NSEC * time.Second):
		// Give give some time to try to join
	}

	// Now leave should be able to finish
	ts.Group(gid2).StartServers()

	select {
	case ok := <-ch:
		if !ok {
			ts.Fatalf("TestJoinLeave5B: Leave failed %t", ok)
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
		ts.partitionCtrler(ck, gid, ka, va)
	}
}

// Test concurrent ctrlers fighting for leadership reliable
func TestConcurrentReliable5C(t *testing.T) {
	ts := MakeTestLeases(t, "Test (5C): Concurrent ctrlers ...", true)
	defer ts.Cleanup()
	ts.setupKVService()
	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)
	ts.concurCtrler(ck, ka, va)
}

// Test concurrent ctrlers fighting for leadership unreliable
func TestAcquireLockConcurrentUnreliable5C(t *testing.T) {
	ts := MakeTestLeases(t, "Test (5C): Concurrent ctrlers ...", false)
	defer ts.Cleanup()
	ts.setupKVService()
	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)
	ts.concurCtrler(ck, ka, va)
}

// Test if old leader is fenced off when reconnecting while it is in
// the middle of a Join.
func TestPartitionControllerJoin5C(t *testing.T) {
	const (
		NSLEEP = 2
		NSEC   = 1
		RAND   = 1000
	)

	ts := MakeTestLeases(t, "Test (5C): partition controller in join...", true)
	defer ts.Cleanup()
	ts.setupKVService()
	ck := ts.MakeClerk()
	ka, va := ts.SpreadPuts(ck, NKEYS)

	sck, clnt := ts.makeShardCtrlerClnt()
	sck.InitController()

	ch := make(chan rpc.Err)
	ngid := tester.Tgid(0)
	go func() {
		ngid = ts.newGid()
		ts.Config.MakeGroupStart(ngid, NSRV, ts.StartServerShardGrp)
		ts.Group(ngid).Shutdown()
		ts.join(sck, ngid, ts.Group(ngid).SrvNames())
		ch <- rpc.OK
	}()

	// sleep for a while to get the chance for the controller to get
	// stuck in join, because gid is down
	time.Sleep(1 * time.Second)

	// partition sck
	clnt.DisconnectAll()

	// wait a while before restarting shardgrp `ngid`
	time.Sleep(NSEC * time.Second)

	ts.Group(ngid).StartServers()

	// start new controller to supersede partitioned one,
	sck0 := ts.makeShardCtrler()
	sck0.InitController()

	scfg := sck0.Query()
	if !scfg.IsMember(ngid) {
		t.Fatalf("Didn't recover gid %d", ngid)
	}

	// reconnect old controller, which shouldn't finish ChangeConfigTo
	clnt.ConnectAll()

	// wait for old controller to finish/exit
	<-ch

	time.Sleep(1 * time.Second)

	for i := 0; i < len(ka); i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}
}

// Make a leader controller loses its leadership during join/leave and
// test if the next controller recovers correctly.
func partitionRecovery5C(t *testing.T, reliable bool, npart, nclnt int) {
	const NSEC = 60
	ts := MakeTestLeases(t, "Test (5C): controllers with leased leadership ...", reliable)
	defer ts.Cleanup()
	gid := ts.setupKVService()
	ck := ts.MakeClerk()

	ka := make([]string, 0)
	va := make([]string, 0)
	if nclnt <= 0 {
		ka, va = ts.SpreadPuts(ck, NKEYS)
	}

	ch := make(chan []kvtest.ClntRes)
	if nclnt > 0 {
		ka := kvtest.MakeKeys(1)
		go func(ch chan []kvtest.ClntRes) {
			rs := ts.SpawnClientsAndWait(nclnt, NSEC*time.Second, func(me int, ck kvtest.IKVClerk, done chan struct{}) kvtest.ClntRes {
				return ts.OneClientPut(me, ck, ka, done)
			})
			ch <- rs
		}(ch)
	}

	for i := 0; i < npart; i++ {
		ts.partitionCtrler(ck, gid, ka, va)
	}

	if nclnt > 0 {
		<-ch
		ts.CheckPorcupine()
	}
}

func TestPartitionRecoveryReliableNoClerk5C(t *testing.T) {
	const (
		NPARTITION = 5
	)
	partitionRecovery5C(t, true, NPARTITION, 0)
}

func TestPartitionRecoveryUnreliableNoClerk5C(t *testing.T) {
	const (
		NPARTITION = 3
	)
	partitionRecovery5C(t, false, NPARTITION, 0)
}

func TestPartitionRecoveryReliableClerks5C(t *testing.T) {
	const (
		NPARTITION = 5
	)
	partitionRecovery5C(t, true, NPARTITION, 5)
}

func TestPartitionRecoveryUnreliableClerks5C(t *testing.T) {
	const (
		NPARTITION = 3
	)
	partitionRecovery5C(t, false, NPARTITION, 5)
}
