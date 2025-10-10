package lock

import (
	"fmt"
	//	"log"
	"strconv"
	"testing"
	"time"

	"6.5840/kvsrv1"
	"6.5840/kvsrv1/rpc"
	"6.5840/kvtest1"
)

const (
	NACQUIRE = 10
	NCLNT    = 10
	NSEC     = 2
)

func oneClient(t *testing.T, me int, ck kvtest.IKVClerk, done chan struct{}) kvtest.ClntRes {
	lk := MakeLock(ck, "l")
	ck.Put("l0", "", 0)
	for i := 1; true; i++ {
		select {
		case <-done:
			return kvtest.ClntRes{i, 0}
		default:
			lk.Acquire()

			// log.Printf("%d: acquired lock", me)

			b := strconv.Itoa(me)
			val, ver, err := ck.Get("l0")
			if err == rpc.OK {
				if val != "" {
					t.Fatalf("%d: two clients acquired lock %v", me, val)
				}
			} else {
				t.Fatalf("%d: get failed %v", me, err)
			}

			err = ck.Put("l0", string(b), ver)
			if !(err == rpc.OK || err == rpc.ErrMaybe) {
				t.Fatalf("%d: put failed %v", me, err)
			}

			time.Sleep(10 * time.Millisecond)

			err = ck.Put("l0", "", ver+1)
			if !(err == rpc.OK || err == rpc.ErrMaybe) {
				t.Fatalf("%d: put failed %v", me, err)
			}

			// log.Printf("%d: release lock", me)

			lk.Release()
		}
	}
	return kvtest.ClntRes{}
}

// Run test clients
func runClients(t *testing.T, nclnt int, reliable bool) {
	ts := kvsrv.MakeTestKV(t, reliable)
	defer ts.Cleanup()

	ts.Begin(fmt.Sprintf("Test: %d lock clients", nclnt))

	ts.SpawnClientsAndWait(nclnt, NSEC*time.Second, func(me int, myck kvtest.IKVClerk, done chan struct{}) kvtest.ClntRes {
		return oneClient(t, me, myck, done)
	})
}

func TestOneClientReliable(t *testing.T) {
	runClients(t, 1, true)
}

func TestManyClientsReliable(t *testing.T) {
	runClients(t, NCLNT, true)
}

func TestOneClientUnreliable(t *testing.T) {
	runClients(t, 1, false)
}

func TestManyClientsUnreliable(t *testing.T) {
	runClients(t, NCLNT, false)
}
