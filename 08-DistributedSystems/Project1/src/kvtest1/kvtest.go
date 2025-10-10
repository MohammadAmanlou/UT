package kvtest

import (
	"encoding/json"
	//"log"
	"math/rand"
	"strconv"
	"testing"
	"time"

	"6.5840/kvsrv1/rpc"
	"6.5840/tester1"
)

// The tester generously allows solutions to complete elections in one second
// (much more than the paper's range of timeouts).
const ElectionTimeout = 1 * time.Second

// n specifies the length of the string to be generated.
func RandValue(n int) string {
	const letterBytes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

	b := make([]byte, n)
	for i := range b {
		b[i] = letterBytes[rand.Int63()%int64(len(letterBytes))]
	}
	return string(b)
}

type IKVClerk interface {
	Get(string) (string, rpc.Tversion, rpc.Err)
	Put(string, string, rpc.Tversion) rpc.Err
}

type TestClerk struct {
	IKVClerk
	Clnt *tester.Clnt
}

type IClerkMaker interface {
	MakeClerk() IKVClerk
	DeleteClerk(IKVClerk)
}

type Test struct {
	*tester.Config
	t          *testing.T
	oplog      *OpLog
	mck        IClerkMaker
	randomkeys bool
}

func MakeTest(t *testing.T, cfg *tester.Config, randomkeys bool, mck IClerkMaker) *Test {
	ts := &Test{
		Config:     cfg,
		t:          t,
		mck:        mck,
		oplog:      &OpLog{},
		randomkeys: randomkeys,
	}
	return ts
}

func (ts *Test) Cleanup() {
	ts.Config.End()
	ts.Config.Cleanup()
}

func (ts *Test) ConnectClnts(clnts []*tester.Clnt) {
	for _, c := range clnts {
		c.ConnectAll()
	}
}

func (ts *Test) MakeClerk() IKVClerk {
	return ts.mck.MakeClerk()
}

// Assumes different ck's put to different keys
func (ts *Test) PutAtLeastOnce(ck IKVClerk, key, value string, ver rpc.Tversion, me int) rpc.Tversion {
	for true {
		err := ts.Put(ck, key, value, ver, me)
		if err == rpc.OK {
			break
		}
		if err == rpc.ErrMaybe || err == rpc.ErrVersion {
			ver += 1
		} else {
			// if failed with ver = 0, retry
			if ver != 0 { // check that ver is indeed 0
				ts.Fatalf("Put %v ver %d err %v", key, ver, err)
			}
		}
	}
	return ver
}

func (ts *Test) CheckGet(ck IKVClerk, key, value string, version rpc.Tversion) {
	val, ver, err := ts.Get(ck, key, 0)
	if err != rpc.OK {
		ts.Fatalf("CheckGet err %v", err)
	}
	if val != value || ver != ver {
		ts.Fatalf("Get(%v): expected:\n%v %v\nreceived:\n%v %v", key, value, val, version, ver)
	}
}

type ClntRes struct {
	Nok    int
	Nmaybe int
}

func (ts *Test) CheckPutConcurrent(ck IKVClerk, key string, rs []ClntRes, res *ClntRes) {
	e := EntryV{}
	ver0 := ts.GetJson(ck, key, -1, &e)
	for _, r := range rs {
		res.Nok += r.Nok
		res.Nmaybe += r.Nmaybe
	}
	if !ts.IsReliable() && ver0 > rpc.Tversion(res.Nok+res.Nmaybe) {
		ts.Fatalf("Wrong number of puts: server %d clnts %v", ver0, res)
	}
	if ts.IsReliable() && ver0 != rpc.Tversion(res.Nok) {
		ts.Fatalf("Wrong number of puts: server %d clnts %v", ver0, res)
	}
}

// a client runs the function f and then signals it is done
func (ts *Test) runClient(me int, ca chan ClntRes, done chan struct{}, mkc IClerkMaker, fn Fclnt) {
	ck := mkc.MakeClerk()
	v := fn(me, ck, done)
	ca <- v
	mkc.DeleteClerk(ck)
}

type Fclnt func(int, IKVClerk, chan struct{}) ClntRes

// spawn ncli clients
func (ts *Test) SpawnClientsAndWait(nclnt int, t time.Duration, fn Fclnt) []ClntRes {
	ca := make([]chan ClntRes, nclnt)
	done := make(chan struct{})
	for cli := 0; cli < nclnt; cli++ {
		ca[cli] = make(chan ClntRes)
		go ts.runClient(cli, ca[cli], done, ts.mck, fn)
	}
	time.Sleep(t)
	for i := 0; i < nclnt; i++ {
		done <- struct{}{}
	}
	rs := make([]ClntRes, nclnt)
	for cli := 0; cli < nclnt; cli++ {
		rs[cli] = <-ca[cli]
	}
	return rs
}

func (ts *Test) GetJson(ck IKVClerk, key string, me int, v any) rpc.Tversion {
	if val, ver, err := Get(ts.Config, ck, key, ts.oplog, me); err == rpc.OK {
		if err := json.Unmarshal([]byte(val), v); err != nil {
			ts.Fatalf("Unmarshal err %v", ver)
		}
		return ver
	} else {
		ts.Fatalf("%d: Get %q err %v", me, key, err)
		return 0
	}
}

func (ts *Test) PutJson(ck IKVClerk, key string, v any, ver rpc.Tversion, me int) rpc.Err {
	b, err := json.Marshal(v)
	if err != nil {
		ts.Fatalf("%d: marshal %v", me, err)
	}
	return Put(ts.Config, ck, key, string(b), ver, ts.oplog, me)
}

func (ts *Test) PutAtLeastOnceJson(ck IKVClerk, key string, value any, ver rpc.Tversion, me int) rpc.Tversion {
	for true {
		if err := ts.PutJson(ck, key, value, 0, me); err != rpc.ErrMaybe {
			break
		}
		ver += 1
	}
	return ver
}

type EntryV struct {
	Id int
	V  rpc.Tversion
}

// Keep trying until we get one put succeeds while other clients
// tryint to put to the same key
func (ts *Test) OnePut(me int, ck IKVClerk, key string, ver rpc.Tversion) (rpc.Tversion, bool) {
	for true {
		err := ts.PutJson(ck, key, EntryV{me, ver}, ver, me)
		if !(err == rpc.OK || err == rpc.ErrVersion || err == rpc.ErrMaybe) {
			ts.Fatalf("Wrong error %v", err)
		}
		e := EntryV{}
		ver0 := ts.GetJson(ck, key, me, &e)
		if err == rpc.OK && ver0 == ver+1 { // my put?
			if e.Id != me && e.V != ver {
				ts.Fatalf("Wrong value %v", e)
			}
		}
		ver = ver0
		if err == rpc.OK || err == rpc.ErrMaybe {
			return ver, err == rpc.OK
		}
	}
	return 0, false
}

// repartition the servers periodically
func (ts *Test) Partitioner(gid tester.Tgid, ch chan bool) {
	defer func() { ch <- true }()
	for true {
		switch {
		case <-ch:
			return
		default:
			a := make([]int, ts.Group(gid).N())
			for i := 0; i < ts.Group(gid).N(); i++ {
				a[i] = (rand.Int() % 2)
			}
			pa := make([][]int, 2)
			for i := 0; i < 2; i++ {
				pa[i] = make([]int, 0)
				for j := 0; j < ts.Group(gid).N(); j++ {
					if a[j] == i {
						pa[i] = append(pa[i], j)
					}
				}
			}
			ts.Group(gid).Partition(pa[0], pa[1])
			time.Sleep(ElectionTimeout + time.Duration(rand.Int63()%200)*time.Millisecond)
		}
	}
}

// One of perhaps many clients doing OnePut's until done signal.
func (ts *Test) OneClientPut(cli int, ck IKVClerk, ka []string, done chan struct{}) ClntRes {
	res := ClntRes{}
	verm := make(map[string]rpc.Tversion)
	for _, k := range ka {
		verm[k] = rpc.Tversion(0)
	}
	ok := false
	for true {
		select {
		case <-done:
			return res
		default:
			k := ka[0]
			if ts.randomkeys {
				k = ka[rand.Int()%len(ka)]
			}
			verm[k], ok = ts.OnePut(cli, ck, k, verm[k])
			if ok {
				res.Nok += 1
			} else {
				res.Nmaybe += 1
			}
		}
	}
	return res
}

func MakeKeys(n int) []string {
	keys := make([]string, n)
	for i := 0; i < n; i++ {
		keys[i] = "k" + strconv.Itoa(i) // ensure multiple shards
	}
	return keys
}

func (ts *Test) SpreadPutsSize(ck IKVClerk, n, valsz int) ([]string, []string) {
	ka := MakeKeys(n)
	va := make([]string, n)
	for i := 0; i < n; i++ {
		va[i] = tester.Randstring(valsz)
		ck.Put(ka[i], va[i], rpc.Tversion(0))
	}
	for i := 0; i < n; i++ {
		ts.CheckGet(ck, ka[i], va[i], rpc.Tversion(1))
	}
	return ka, va
}

func (ts *Test) SpreadPuts(ck IKVClerk, n int) ([]string, []string) {
	return ts.SpreadPutsSize(ck, n, 20)
}

type entry struct {
	Id int
	N  int
}

// At each iteration i, oneClient attemps to appends a tuple (me, i)
// to a key "k" shared with other clients.  The client implements the
// append by first performing a Clerk.Get and then a Clerk.Put with
// the version number returned from the Get.  If another client
// performs an append between the Get and the Put, the clerk may
// return ErrVersion and the client can retry.  If the clerk returns
// ErrMaybe, the client's Put may have succeeded or not; in both
// cases, the client moves to the next iteration.  When running with
// many clients, the server's value for key "k" has the shape [(i, 1),
// (i, 2), (j, 1), (j, 3)...]: that is, each client has entries with
// increasing N, but may some Ns may have been skipped.
func (ts *Test) OneClientAppend(me int, ck IKVClerk, done chan struct{}) ClntRes {
	nmay := 0
	nok := 0
	for i := 0; true; i++ {
		select {
		case <-done:
			return ClntRes{nok, nmay}
		default:
			// keep trying to put my i when err == ErrVersion
			for true {
				es := []entry{}
				ver := ts.GetJson(ck, "k", me, &es)
				es = append(es, entry{me, i})
				if err := ts.PutJson(ck, "k", es, ver, me); err == rpc.OK {
					nok += 1
					break
				} else if err == rpc.ErrMaybe {
					// DPrintf("put %v err %v", ver, err)
					nmay += 1
					break
				}
			}
		}
	}
	return ClntRes{}
}

type EntryN struct {
	Id int
	N  int
}

// check reads the latest value for key "k" and checks that it has the
// correct tuples.
func (ts *Test) CheckAppends(es []EntryN, nclnt int, rs []ClntRes, ver rpc.Tversion) {
	expect := make(map[int]int)
	skipped := make(map[int]int)
	for i := 0; i < nclnt; i++ {
		expect[i] = 0
		skipped[i] = 0
	}
	for _, e := range es {
		if expect[e.Id] > e.N { // old put?
			ts.Fatalf("%d: wrong expecting %v but got %v", e.Id, expect[e.Id], e.N)
		} else if expect[e.Id] == e.N {
			expect[e.Id] += 1
		} else { // missing entries because of failed put
			s := (e.N - expect[e.Id])
			expect[e.Id] = e.N + 1
			skipped[e.Id] += s
		}
	}
	if len(es)+1 != int(ver) {
		ts.Fatalf("%d appends in val != puts on server %d", len(es), ver)
	}
	for c, n := range expect {
		if skipped[c] > rs[c].Nmaybe {
			ts.Fatalf("%d: skipped puts %d on server > %d maybe", c, skipped[c], rs[c].Nmaybe)
		}
		if n > rs[c].Nok+rs[c].Nmaybe {
			ts.Fatalf("%d: %d puts on server > ok+maybe %d", c, n, rs[c].Nok+rs[c].Nmaybe)
		}
	}
}
