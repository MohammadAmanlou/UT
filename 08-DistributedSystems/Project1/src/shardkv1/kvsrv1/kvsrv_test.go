package kvsrv

import (
	// "log"
	"runtime"
	"testing"
	"time"

	"6.5840/kvsrv1/rpc"
	"6.5840/kvtest1"
)

// Test Put with a single client and a reliable network
func TestReliablePut(t *testing.T) {
	const Val = "6.5840"
	const Ver = 0

	ts := MakeTestKV(t, true)
	defer ts.Cleanup()

	ts.Begin("One client and reliable Put")

	ck := ts.MakeClerk()
	if err := ck.Put("k", Val, Ver); err != rpc.OK {
		t.Fatalf("Put err %v", err)
	}

	if val, ver, err := ck.Get("k"); err != rpc.OK {
		t.Fatalf("Get err %v; expected OK", err)
	} else if val != Val {
		t.Fatalf("Get value err %v; expected %v", val, Val)
	} else if ver != Ver+1 {
		t.Fatalf("Get wrong version %v; expected %v", ver, Ver+1)
	}

	if err := ck.Put("k", Val, 0); err != rpc.ErrVersion {
		t.Fatalf("expected Put to fail with ErrVersion; got err=%v", err)
	}

	if err := ck.Put("y", Val, rpc.Tversion(1)); err != rpc.ErrNoKey {
		t.Fatalf("expected Put to fail with ErrNoKey; got err=%v", err)
	}

	if _, _, err := ck.Get("y"); err != rpc.ErrNoKey {
		t.Fatalf("expected Get to fail with ErrNoKey; got err=%v", err)
	}
}

// Many clients putting on same key.
func TestPutConcurrentReliable(t *testing.T) {
	const (
		PORCUPINETIME = 10 * time.Second
		NCLNT         = 10
		NSEC          = 1
	)

	ts := MakeTestKV(t, true)
	defer ts.Cleanup()

	ts.Begin("Test: many clients racing to put values to the same key")

	rs := ts.SpawnClientsAndWait(NCLNT, NSEC*time.Second, func(me int, ck kvtest.IKVClerk, done chan struct{}) kvtest.ClntRes {
		return ts.OneClientPut(me, ck, []string{"k"}, done)
	})
	ck := ts.MakeClerk()
	ts.CheckPutConcurrent(ck, "k", rs, &kvtest.ClntRes{})
	ts.CheckPorcupineT(PORCUPINETIME)
}

// Check if memory used on server is reasonable
func TestMemPutManyClientsReliable(t *testing.T) {
	const (
		NCLIENT = 100_000
		MEM     = 1000
	)

	ts := MakeTestKV(t, true)
	defer ts.Cleanup()

	v := kvtest.RandValue(MEM)

	cks := make([]kvtest.IKVClerk, NCLIENT)
	for i, _ := range cks {
		cks[i] = ts.MakeClerk()
	}

	// force allocation of ends for server in each client
	for i := 0; i < NCLIENT; i++ {
		if err := cks[i].Put("k", "", 1); err != rpc.ErrNoKey {
			t.Fatalf("Put failed %v", err)
		}
	}

	ts.Begin("Test: memory use many put clients")

	// allow threads started by labrpc to start
	time.Sleep(1 * time.Second)

	runtime.GC()
	runtime.GC()

	var st runtime.MemStats
	runtime.ReadMemStats(&st)
	m0 := st.HeapAlloc

	for i := 0; i < NCLIENT; i++ {
		if err := cks[i].Put("k", v, rpc.Tversion(i)); err != rpc.OK {
			t.Fatalf("Put failed %v", err)
		}
	}

	runtime.GC()
	time.Sleep(1 * time.Second)
	runtime.GC()

	runtime.ReadMemStats(&st)
	m1 := st.HeapAlloc
	f := (float64(m1) - float64(m0)) / NCLIENT
	if m1 > m0+(NCLIENT*200) {
		t.Fatalf("error: server using too much memory %d %d (%.2f per client)\n", m0, m1, f)
	}
}

// Test with one client and unreliable network. If Clerk.Put returns
// ErrMaybe, the Put must have happened, since the test uses only one
// client.
func TestUnreliableNet(t *testing.T) {
	const NTRY = 100

	ts := MakeTestKV(t, false)
	defer ts.Cleanup()

	ts.Begin("One client")

	ck := ts.MakeClerk()

	retried := false
	for try := 0; try < NTRY; try++ {
		for i := 0; true; i++ {
			if err := ts.PutJson(ck, "k", i, rpc.Tversion(try), 0); err != rpc.ErrMaybe {
				if i > 0 && err != rpc.ErrVersion {
					t.Fatalf("Put shouldn't have happen more than once %v", err)
				}
				break
			}
			// Try put again; it should fail with ErrVersion
			retried = true
		}
		v := 0
		if ver := ts.GetJson(ck, "k", 0, &v); ver != rpc.Tversion(try+1) {
			t.Fatalf("Wrong version %d expect %d", ver, try+1)
		}
		if v != 0 {
			t.Fatalf("Wrong value %d expect %d", v, 0)
		}
	}
	if !retried {
		t.Fatalf("Clerk.Put never returned ErrMaybe")
	}

	ts.CheckPorcupine()
}
