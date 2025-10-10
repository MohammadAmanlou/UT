package kvraft

import (
	//"log"
	"strconv"
	"testing"
	"time"

	"6.5840/kvraft1/rsm"
	"6.5840/kvsrv1/rpc"
	"6.5840/kvtest1"
)

const (
	NSEC  = 1
	NCLNT = 10
)

// Basic test is as follows: one or more clients submitting Puts/Gets
// operations to set of servers for some period of time using
// kvtest.OneClientPut.  After the period is over, test checks that all
// puts/gets values form a linearizable history. If unreliable is set,
// RPCs may fail.  If crash is set, the servers crash after the period
// is over and restart.  If partitions is set, the test repartitions
// the network concurrently with the clients and servers. If
// maxraftstate is a positive number, the size of the state for Raft
// (i.e., log size) shouldn't exceed 8*maxraftstate. If maxraftstate
// is negative, snapshots shouldn't be used.
func (ts *Test) GenericTest() {
	const (
		NITER = 3
		T     = NSEC * time.Second
		NKEYS = 100
	)
	// const T = 1 * time.Millisecond
	defer ts.Cleanup()

	ch_partitioner := make(chan bool)
	ch_spawn := make(chan struct{})
	ck := ts.MakeClerk()
	res := kvtest.ClntRes{}
	default_key := []string{"k"} // if not running with randomkeys
	if ts.randomkeys {
		default_key = kvtest.MakeKeys(NKEYS)
	}
	for i := 0; i < NITER; i++ {
		// log.Printf("Iteration %v\n", i)

		go func() {
			rs := ts.SpawnClientsAndWait(ts.nclients, T, func(cli int, ck kvtest.IKVClerk, done chan struct{}) kvtest.ClntRes {
				return ts.OneClientPut(cli, ck, default_key, done)
			})
			if !ts.randomkeys {
				ts.CheckPutConcurrent(ck, default_key[0], rs, &res)
			}
			ch_spawn <- struct{}{}
		}()

		if ts.partitions {
			// Allow the clients to perform some operations without interruption
			time.Sleep(1 * time.Second)
			go ts.Partitioner(Gid, ch_partitioner)
		}

		<-ch_spawn // wait for clients to be done

		ts.CheckPorcupine()

		if ts.partitions {
			ch_partitioner <- true
			// log.Printf("wait for partitioner\n")
			<-ch_partitioner
			// reconnect network and submit a request. A client may
			// have submitted a request in a minority.  That request
			// won't return until that server discovers a new term
			// has started.
			ts.Group(Gid).ConnectAll()
			// wait for a while so that we have a new term
			time.Sleep(kvtest.ElectionTimeout)
		}

		if ts.crash {
			// log.Printf("shutdown servers\n")
			for i := 0; i < ts.nservers; i++ {
				ts.Group(Gid).ShutdownServer(i)
			}
			// Wait for a while for servers to shutdown, since
			// shutdown isn't a real crash and isn't instantaneous
			time.Sleep(kvtest.ElectionTimeout)
			// log.Printf("restart servers\n")
			// crash and re-start all
			for i := 0; i < ts.nservers; i++ {
				ts.Group(Gid).StartServer(i)
			}
			ts.Group(Gid).ConnectAll()
		}

		if ts.maxraftstate > 0 {
			// Check maximum after the servers have processed all client
			// requests and had time to checkpoint.
			sz := ts.Config.Group(Gid).LogSize()
			if sz > 8*ts.maxraftstate {
				ts.t.Fatalf("logs were not trimmed (%v > 8*%v)", sz, ts.maxraftstate)
			}
		}
		if ts.maxraftstate < 0 {
			// Check that snapshots are not used
			ssz := ts.Group(Gid).SnapshotSize()
			if ssz > 0 {
				ts.t.Fatalf("snapshot too large (%v), should not be used when maxraftstate = %d", ssz, ts.maxraftstate)
			}
		}
	}
}

// check that ops are committed fast enough, better than 1 per heartbeat interval
func (ts *Test) GenericTestSpeed() {
	const numOps = 1000

	defer ts.Cleanup()

	ck := ts.MakeClerk()

	// wait until first op completes, so we know a leader is elected
	// and KV servers are ready to process client requests
	ck.Get("x")

	start := time.Now()
	for i := 0; i < numOps; i++ {
		if err := ck.Put("k", strconv.Itoa(i), rpc.Tversion(i)); err != rpc.OK {
			ts.t.Fatalf("Put err %v", err)
		}
	}
	dur := time.Since(start)

	if _, ver, err := ck.Get("k"); err != rpc.OK {
		ts.t.Fatalf("Get err %v", err)
	} else if ver != numOps {
		ts.t.Fatalf("Get too few ops %v", ver)
	}

	// heartbeat interval should be ~ 100 ms; require at least 3 ops per
	const heartbeatInterval = 100 * time.Millisecond
	const opsPerInterval = 3
	const timePerOp = heartbeatInterval / opsPerInterval
	if dur > numOps*timePerOp {
		ts.t.Fatalf("Operations completed too slowly %v/op > %v/op\n", dur/numOps, timePerOp)
	}
}

func TestBasic4B(t *testing.T) {
	ts := MakeTest(t, "4B basic", 1, 5, true, false, false, -1, false)
	ts.GenericTest()
}

func TestSpeed4B(t *testing.T) {
	ts := MakeTest(t, "4B speed", 1, 3, true, false, false, -1, false)
	ts.GenericTestSpeed()
}

func TestConcurrent4B(t *testing.T) {
	ts := MakeTest(t, "4B many clients", 5, 5, true, false, false, -1, false)
	ts.GenericTest()
}

func TestUnreliable4B(t *testing.T) {
	ts := MakeTest(t, "4B unreliable net, many clients", 5, 5, false, false, false, -1, false)
	ts.GenericTest()
}

// Submit a request in the minority partition and check that the requests
// doesn't go through until the partition heals.  The leader in the original
// network ends up in the minority partition.
func TestOnePartition4B(t *testing.T) {
	ts := MakeTest(t, "4B progress in majority", 0, 5, false, false, false, -1, false)
	defer ts.Cleanup()

	ck := ts.MakeClerk()

	ver0 := ts.PutAtLeastOnce(ck, "1", "13", rpc.Tversion(0), -1)

	_, l := rsm.Leader(ts.Config, Gid)
	p1, p2 := ts.Group(Gid).MakePartition(l)
	ts.Group(Gid).Partition(p1, p2)

	ckp1 := ts.MakeClerkTo(p1)  // connect ckp1 to p1
	ckp2a := ts.MakeClerkTo(p2) // connect ckp2a to p2
	ckp2b := ts.MakeClerkTo(p2) // connect ckp2b to p2

	ver1 := ts.PutAtLeastOnce(ckp1, "1", "14", ver0+1, -1)
	ts.CheckGet(ckp1, "1", "14", ver1)

	ts.End()

	done0 := make(chan rpc.Tversion)
	done1 := make(chan rpc.Tversion)

	ts.Begin("Test: no progress in minority (4B)")
	go func() {
		ver := ts.PutAtLeastOnce(ckp2a, "1", "15", ver1+1, -1)
		done0 <- ver
	}()
	go func() {
		_, ver, _ := ts.Get(ckp2b, "1", -1) // different clerk in p2
		done1 <- ver
	}()

	select {
	case ver := <-done0:
		t.Fatalf("Put in minority completed %v", ver)
	case ver := <-done1:
		t.Fatalf("Get in minority completed %v", ver)
	case <-time.After(time.Second):
	}

	ts.CheckGet(ckp1, "1", "14", ver1)
	ver2 := ts.PutAtLeastOnce(ckp1, "1", "16", ver1+1, -1)
	ts.CheckGet(ckp1, "1", "16", ver2)

	ts.End()

	ts.Begin("Test: completion after heal (4B)")

	ts.Group(Gid).ConnectAll()
	ckp2a.(*kvtest.TestClerk).Clnt.ConnectAll()
	ckp2b.(*kvtest.TestClerk).Clnt.ConnectAll()

	time.Sleep(kvtest.ElectionTimeout)

	select {
	case <-done0:
	case <-time.After(30 * 100 * time.Millisecond):
		t.Fatalf("Put did not complete")
	}

	select {
	case <-done1:
	case <-time.After(30 * 100 * time.Millisecond):
		t.Fatalf("Get did not complete")
	default:
	}

	ts.CheckGet(ck, "1", "15", ver2+1)
}

func TestManyPartitionsOneClient4B(t *testing.T) {
	ts := MakeTest(t, "4B partitions, one client", 1, 5, false, false, true, -1, false)
	ts.GenericTest()
}

func TestManyPartitionsManyClients4B(t *testing.T) {
	ts := MakeTest(t, "4B partitions, many clients (4B)", 5, 5, false, false, true, -1, false)
	ts.GenericTest()
}

func TestPersistOneClient4B(t *testing.T) {
	ts := MakeTest(t, "4B restarts, one client 4B ", 1, 5, false, true, false, -1, false)
	ts.GenericTest()
}

func TestPersistConcurrent4B(t *testing.T) {
	ts := MakeTest(t, "4B restarts, many clients", 5, 5, false, true, false, -1, false)
	ts.GenericTest()
}

func TestPersistConcurrentUnreliable4B(t *testing.T) {
	ts := MakeTest(t, "4B unreliable net, restarts, many clients ", 5, 5, true, true, false, -1, false)
	ts.GenericTest()
}

func TestPersistPartition4B(t *testing.T) {
	ts := MakeTest(t, "4B restarts, partitions, many clients", 5, 5, false, true, true, -1, false)
	ts.GenericTest()
}

func TestPersistPartitionUnreliable4B(t *testing.T) {
	ts := MakeTest(t, "4B unreliable net, restarts, partitions, many clients", 5, 5, true, true, true, -1, false)
	ts.GenericTest()
}

func TestPersistPartitionUnreliableLinearizable4B(t *testing.T) {
	ts := MakeTest(t, "4B unreliable net, restarts, partitions, random keys, many clients", 15, 7, true, true, true, -1, true)
	ts.GenericTest()
}

// if one server falls behind, then rejoins, does it
// recover by using the InstallSnapshot RPC?
// also checks that majority discards committed log entries
// even if minority doesn't respond.
func TestSnapshotRPC4C(t *testing.T) {
	const (
		NSRV         = 3
		MAXRAFTSTATE = 1000
	)
	ts := MakeTest(t, "4C SnapshotsRPC", 0, NSRV, true, false, false, MAXRAFTSTATE, false)
	defer ts.Cleanup()

	ck := ts.MakeClerk()

	ts.Begin("Test: InstallSnapshot RPC (4C)")

	vera := ts.PutAtLeastOnce(ck, "a", "A", rpc.Tversion(0), -1)
	ts.CheckGet(ck, "a", "A", vera)

	verb := rpc.Tversion(0)
	// a bunch of puts into the majority partition.
	ts.Group(Gid).Partition([]int{0, 1}, []int{2})
	{
		ck1 := ts.MakeClerkTo([]int{0, 1})
		for i := 0; i < 50; i++ {
			ts.PutAtLeastOnce(ck1, strconv.Itoa(i), strconv.Itoa(i), rpc.Tversion(0), -1)
		}
		time.Sleep(kvtest.ElectionTimeout)
		verb = ts.PutAtLeastOnce(ck1, "b", "B", rpc.Tversion(0), -1)
	}

	// check that the majority partition has thrown away
	// most of its log entries.
	sz := ts.Group(Gid).LogSize()
	if sz > 8*ts.maxraftstate {
		t.Fatalf("logs were not trimmed (%v > 8*%v)", sz, ts.maxraftstate)
	}

	// now make group that requires participation of
	// lagging server, so that it has to catch up.
	ts.Group(Gid).Partition([]int{0, 2}, []int{1})
	{
		ck1 := ts.MakeClerkTo([]int{0, 2})
		ts.PutAtLeastOnce(ck1, "c", "C", rpc.Tversion(0), -1)
		ts.PutAtLeastOnce(ck1, "d", "D", rpc.Tversion(0), -1)
		ts.CheckGet(ck1, "a", "A", vera)
		ts.CheckGet(ck1, "b", "B", verb)
		ts.CheckGet(ck1, "1", "1", rpc.Tversion(1))
		ts.CheckGet(ck1, "49", "49", rpc.Tversion(1))
	}

	// now everybody
	ts.Group(Gid).Partition([]int{0, 1, 2}, []int{})

	vere := ts.PutAtLeastOnce(ck, "e", "E", rpc.Tversion(0), -1)
	ts.CheckGet(ck, "c", "C", 1)
	ts.CheckGet(ck, "e", "E", vere)
	ts.CheckGet(ck, "1", "1", rpc.Tversion(1))
}

// are the snapshots not too huge? 500 bytes is a generous bound for the
// operations we're doing here.
func TestSnapshotSize4C(t *testing.T) {
	ts := MakeTest(t, "4C snapshot size is reasonable", 0, 3, true, false, false, 1000, false)
	defer ts.Cleanup()

	maxsnapshotstate := 500

	ck := ts.MakeClerk()

	ver := rpc.Tversion(0)
	for i := 0; i < 200; i++ {
		ver = ts.PutAtLeastOnce(ck, "x", "0", ver, -1)
		ts.CheckGet(ck, "x", "0", ver)
		ver = ts.PutAtLeastOnce(ck, "x", "1", ver+1, -1)
		ts.CheckGet(ck, "x", "1", ver)
		ver += 1
	}

	// check that servers have thrown away most of their log entries
	sz := ts.Group(Gid).LogSize()
	if sz > 8*ts.maxraftstate {
		t.Fatalf("logs were not trimmed (%v > 8*%v)", sz, ts.maxraftstate)
	}

	// check that the snapshots are not unreasonably large
	ssz := ts.Group(Gid).SnapshotSize()
	if ssz > maxsnapshotstate {
		t.Fatalf("snapshot too large (%v > %v)", ssz, maxsnapshotstate)
	}
}

func TestSpeed4C(t *testing.T) {
	ts := MakeTest(t, "4C speed", 1, 3, true, false, false, 1000, false)
	ts.GenericTestSpeed()
}

func TestSnapshotRecover4C(t *testing.T) {
	ts := MakeTest(t, "4C restarts, snapshots, one client", 1, 5, true, true, false, 1000, false)
	ts.GenericTest()
}

func TestSnapshotRecoverManyClients4C(t *testing.T) {
	ts := MakeTest(t, "4C restarts, snapshots, many clients ", 20, 5, true, true, false, 1000, false)
	ts.GenericTest()
}

func TestSnapshotUnreliable4C(t *testing.T) {
	ts := MakeTest(t, "4C unreliable net, snapshots, many clients", 5, 5, false, false, false, 1000, false)
	ts.GenericTest()
}

func TestSnapshotUnreliableRecover4C(t *testing.T) {
	ts := MakeTest(t, "4C unreliable net, restarts, snapshots, many clients", 5, 5, false, true, false, 1000, false)
	ts.GenericTest()
}

func TestSnapshotUnreliableRecoverConcurrentPartition4C(t *testing.T) {
	ts := MakeTest(t, "4C unreliable net, restarts, partitions, snapshots, many clients", 5, 5, false, true, true, 1000, false)
	ts.GenericTest()
}

func TestSnapshotUnreliableRecoverConcurrentPartitionLinearizable4C(t *testing.T) {
	ts := MakeTest(t, "4C unreliable net, restarts, partitions, snapshots, random keys, many clients", 15, 7, false, true, true, 1000, true)
	ts.GenericTest()
}
