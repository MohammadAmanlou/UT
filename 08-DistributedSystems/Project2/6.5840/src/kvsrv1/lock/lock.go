package lock

import (
	"6.5840/kvsrv1/rpc"
	"6.5840/kvtest1"
	"sync"
	"time"
)

type Lock struct {
	// IKVClerk is a go interface for k/v clerks: the interface hides
	// the specific Clerk type of ck but promises that ck supports
	// Put and Get.  The tester passes the clerk in when calling
	// MakeLock().
	ck kvtest.IKVClerk

	clientId string
	lockKey  string
	mu sync.Mutex
}
// The tester calls MakeLock() and passes in a k/v clerk; your code can
// perform a Put or Get by calling lk.ck.Put() or lk.ck.Get().
//
// Use l as the key to store the "lock state" (you would have to decide
// precisely what the lock state is).
func MakeLock(ck kvtest.IKVClerk, l string) *Lock {
	lk := &Lock{
		ck:       ck,
		lockKey:  l,
		clientId: kvtest.RandValue(8),
	}

	return lk
}

func (lk *Lock) Acquire() {
	i := 100
	for {
		lk.mu.Lock()
		val, version, err := lk.ck.Get(lk.lockKey)

		if val == lk.clientId {
			lk.mu.Unlock()
			return
		}

		if err == rpc.ErrNoKey || (err == rpc.OK && val == "") {
			err = lk.ck.Put(lk.lockKey, lk.clientId, version)
			if err == rpc.OK {
				lk.mu.Unlock()
				return
			}
		}

		lk.mu.Unlock()
		time.Sleep(time.Duration(i) * time.Millisecond)
		i += 10
	}
}

func (lk *Lock) Release() {
	i := 100
	for {
		lk.mu.Lock()
		value, version, err := lk.ck.Get(lk.lockKey)

		if err == rpc.OK && value == lk.clientId {
			lk.ck.Put(lk.lockKey, "", version)
			lk.mu.Unlock()
			break
		}

		lk.mu.Unlock()
		time.Sleep(time.Duration(i) * time.Millisecond)
		i += 10
	}
}
