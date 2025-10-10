package rsm

import (
	//"log"
	"fmt"
	"sync"
	"testing"
	"time"

	"6.5840/kvsrv1/rpc"
	"6.5840/tester1"
)

// test that each server executes increments and updates its counter.
func TestBasic4A(t *testing.T) {
	const NINC = 10
	ts := makeTest(t, -1)
	defer ts.cleanup()

	tester.AnnotateTest("TestBasic4A", NSRV)
	ts.Begin("Test RSM basic")

	for i := 0; i < NINC; i++ {
		r := ts.oneInc()
		if r.N != i+1 {
			err := fmt.Sprintf("expected %d instead of %d", i, r.N)
			tester.AnnotateCheckerFailure(err, err)
			ts.t.Fatalf(err)
		}
		ts.checkCounter(r.N, NSRV)
	}
}

// test submitting concurrently
func TestConcurrent4A(t *testing.T) {
	const NINC = 50
	ts := makeTest(t, -1)
	defer ts.cleanup()

	tester.AnnotateTest("TestConcurrent4A", NSRV)
	ts.Begin("Test concurrent submit")

	var wg sync.WaitGroup
	for i := 0; i < NINC; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			ts.oneInc()
		}()
	}
	wg.Wait()
	ts.checkCounter(NINC, NSRV)
}

// test that each server executes increments after disconnecting and
// reconnecting leader
func TestLeaderFailure4A(t *testing.T) {
	ts := makeTest(t, -1)
	defer ts.cleanup()

	tester.AnnotateTest("TestLeaderFailure4A", NSRV)
	ts.Begin("Test Leader Failure")

	r := ts.oneInc()
	ts.checkCounter(r.N, NSRV)

	l := ts.disconnectLeader()
	tester.AnnotateConnection(ts.g.GetConnected())
	r = ts.oneInc()
	ts.checkCounter(r.N, NSRV-1)

	ts.connect(l)
	tester.AnnotateConnection(ts.g.GetConnected())

	ts.checkCounter(r.N, NSRV)
}

// test that partitioned leader doesn't commit an operation
func TestLeaderPartition4A(t *testing.T) {
	const NSUBMIT = 100

	ts := makeTest(t, -1)
	defer ts.cleanup()

	tester.AnnotateTest("TestLeaderPartition4A", NSRV)
	ts.Begin("Test Leader Partition")

	// submit an Inc
	r := ts.oneInc()
	ts.checkCounter(r.N, NSRV)

	// partition leader
	foundl, l := Leader(ts.Config, Gid)
	if foundl {
		text := fmt.Sprintf("leader found = %v", l)
		tester.AnnotateInfo(text, text)
	} else {
		text := "did not find a leader"
		tester.AnnotateInfo(text, text)
	}
	p1, p2 := ts.Group(Gid).MakePartition(l)
	ts.Group(Gid).Partition(p1, p2)
	tester.AnnotateTwoPartitions(p1, p2)

	text := fmt.Sprintf("concurrently submitting %v Dec to %v", NSUBMIT, l)
	tester.AnnotateInfo(text, text)
	done := make(chan struct{})
	go func() {
		// Submit many Dec's concurrently, which will results in many
		// raft.Start()'s, but none should commit and be executed.
		var wg sync.WaitGroup
		for i := 0; i < NSUBMIT; i++ {
			wg.Add(1)
			go func(i int) {
				defer wg.Done()
				if err, rep := ts.srvs[l].rsm.Submit(Dec{}); err == rpc.OK {
					t.Fatalf("Submit %d in minority completed %v", i, rep)
				}
			}(i)
		}
		wg.Wait()
		done <- struct{}{}
	}()

	// give old leader some time to submit
	time.Sleep(10 * time.Millisecond)

	// submit an Inc in the majority
	rep := ts.onePartition(p1, Inc{})

	select {
	case err := <-done:
		text := fmt.Sprintf("Dec's in minority completed; Submit returns %v", err)
		tester.AnnotateCheckerFailure(text, text)
		ts.Fatalf(text)
	case <-time.After(time.Second):
	}

	// reconnect leader
	ts.connect(l)
	// use the fact that there are only three servers, so connecting the leader
	// resolves all partitions (the last line of test also relies on this)
	tester.AnnotateClearFailure()

	select {
	case <-done:
	case <-time.After(time.Second):
		text := "Submit after healing didn't return"
		tester.AnnotateCheckerFailure(text, text)
		ts.Fatalf(text)
	}

	// check that all replicas have the same value for counter
	ts.checkCounter(rep.(*IncRep).N, NSRV)
}

// test that restart replays Incs
func TestRestartReplay4A(t *testing.T) {
	const (
		NINC    = 100
		NSUBMIT = 100
	)

	ts := makeTest(t, -1)
	defer ts.cleanup()

	tester.AnnotateTest("TestRestartReplay4A", NSRV)
	ts.Begin("Test Restart")

	for i := 0; i < NINC; i++ {
		r := ts.oneInc()
		if r.N != i+1 {
			err := fmt.Sprintf("expected %d instead of %d", i, r.N)
			tester.AnnotateCheckerFailure(err, err)
			ts.t.Fatalf(err)
		}
		ts.checkCounter(r.N, NSRV)
	}

	ts.Group(Gid).Shutdown()
	tester.AnnotateShutdownAll()

	time.Sleep(1 * time.Second)

	ts.Group(Gid).StartServers()
	tester.AnnotateRestartAll()

	// submit an Inc
	r := ts.oneInc()

	if r.N != NINC+1 {
		err := fmt.Sprintf("expected %d got %d", NINC+1, r.N)
		tester.AnnotateCheckerFailure(err, err)
		t.Fatalf(err)
	}

	time.Sleep(1 * time.Second)

	ts.checkCounter(r.N, NSRV)
}

// Test if Submit() terminates after tester's Shutdown() has called
// raft's Kill().  Kill() should cause your raft to close the applyCh
// passed to it in Make(), which in turns allows rsm to know that it
// is done.
func TestShutdown4A(t *testing.T) {
	const (
		NSUBMIT = 100
	)

	ts := makeTest(t, -1)
	defer ts.cleanup()

	tester.AnnotateTest("TestShutdown4A", NSRV)
	ts.Begin("Test Shutdown")

	// Submit many Null's concurrently
	done := make(chan struct{})
	go func() {
		var wg sync.WaitGroup
		for i := 0; i < NSUBMIT; i++ {
			wg.Add(1)
			go func(i int) {
				defer wg.Done()
				ts.oneNull()
			}(i)
		}
		wg.Wait()
		done <- struct{}{}
	}()

	// give some time to submit
	time.Sleep(20 * time.Millisecond)

	ts.Group(Gid).Shutdown()
	tester.AnnotateShutdownAll()

	select {
	case <-done:
	case <-time.After((NSEC + 1) * time.Second):
		err := "Submit didn't stop after shutdown"
		tester.AnnotateCheckerFailure(err, err)
		ts.Fatalf(err)
	}
}

// Test if commands after restart don't get confused with ones
// submitted before Shutdown()
func TestRestartSubmit4A(t *testing.T) {
	const (
		NINC    = 100
		NSUBMIT = 100
	)

	ts := makeTest(t, -1)
	defer ts.cleanup()

	tester.AnnotateTest("TestRestartSubmit4A", NSRV)
	ts.Begin("Test Restart and submit")

	for i := 0; i < NINC; i++ {
		r := ts.oneInc()
		if r.N != i+1 {
			err := fmt.Sprintf("expected %d instead of %d", i, r.N)
			tester.AnnotateCheckerFailure(err, err)
			ts.t.Fatalf(err)
		}
		ts.checkCounter(r.N, NSRV)
	}

	ts.Group(Gid).Shutdown()
	tester.AnnotateShutdownAll()

	time.Sleep(1 * time.Second)

	ts.Group(Gid).StartServers()
	tester.AnnotateRestartAll()

	// submit an Inc
	r := ts.oneInc()

	if r.N != NINC+1 {
		err := fmt.Sprintf("Expected %d got %d", NINC+1, r.N)
		tester.AnnotateCheckerFailure(err, err)
		t.Fatalf(err)
	}

	time.Sleep(1 * time.Second)

	// Submit many Null's concurrently
	text := fmt.Sprintf("concurrently submitting %v Null", NSUBMIT)
	tester.AnnotateInfo(text, text)
	done := make(chan struct{})
	go func() {
		var wg sync.WaitGroup
		for i := 0; i < NSUBMIT; i++ {
			wg.Add(1)
			go func(i int) {
				defer wg.Done()
				ts.oneNull()
			}(i)
		}
		wg.Wait()
		done <- struct{}{}
	}()

	// give some time to submit
	time.Sleep(20 * time.Millisecond)

	ts.Group(Gid).Shutdown()
	tester.AnnotateShutdownAll()

	select {
	case <-done:
	case <-time.After((NSEC + 1) * time.Second):
		err := "Submit didn't stop after shutdown"
		tester.AnnotateCheckerFailure(err, err)
		ts.Fatalf(err)
	}

	ts.Group(Gid).StartServers()
	tester.AnnotateRestartAll()

	r = ts.oneInc()
	ts.checkCounter(r.N, NSRV)
}

// test snapshot and restore
func TestSnapshot4C(t *testing.T) {
	const (
		N            = 100
		MAXRAFTSTATE = 1000
	)

	ts := makeTest(t, MAXRAFTSTATE)
	defer ts.cleanup()

	tester.AnnotateTest("TestSnapshot4C", NSRV)
	ts.Begin("Test creating and restoring snapshot")

	for i := 0; i < N; i++ {
		ts.oneInc()
	}
	ts.checkCounter(N, NSRV)

	sz := ts.Group(Gid).LogSize()
	if sz > 2*MAXRAFTSTATE {
		err := fmt.Sprintf("logs were not trimmed (%v > 2 * %v)", sz, ts.maxraftstate)
		tester.AnnotateCheckerFailure(err, err)
		ts.Fatalf(err)
	}

	// rsm must have made snapshots by now; shutdown all servers and
	// restart them from a snapshot

	ts.g.Shutdown()
	tester.AnnotateShutdownAll()
	ts.g.StartServers()
	tester.AnnotateRestartAll()

	// make restarted servers do one increment
	ts.oneInc()

	ts.checkCounter(N+1, NSRV)
}
