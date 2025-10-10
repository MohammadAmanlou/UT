package kvsrv

import (
	"log"
	"sync"

	"6.5840/kvsrv1/rpc"
	"6.5840/labrpc"
	"6.5840/tester1"
)

const Debug = false

func DPrintf(format string, a ...interface{}) (n int, err error) {
	if Debug {
		log.Printf(format, a...)
	}
	return
}

type Record struct {
	Value   string
	Version rpc.Tversion
}

type KVServer struct {
	mu      sync.Mutex
	records map[string]*Record
}

func MakeKVServer() *KVServer {
	kv := &KVServer{}
	kv.records = make(map[string]*Record)
	return kv
}

func (kv *KVServer) Get(args *rpc.GetArgs, reply *rpc.GetReply) {
	kv.mu.Lock()
	defer kv.mu.Unlock()

	record, ok := kv.records[args.Key]
	if !ok {
		reply.Err = rpc.ErrNoKey
		return
	}

	reply.Err = rpc.OK
	reply.Version = record.Version
	reply.Value = record.Value
}

// Update the value for a key if args.Version matches the version of
// the key on the server. If versions don't match, return ErrVersion.
// If the key doesn't exist, Put installs the value if the
// args.Version is 0, and returns ErrNoKey otherwise.
func (kv *KVServer) Put(args *rpc.PutArgs, reply *rpc.PutReply) {
	kv.mu.Lock()
	defer kv.mu.Unlock()

	record, exists := kv.records[args.Key]
	switch {
	case !exists && args.Version == 0:
		kv.records[args.Key] = &Record{
			Value:   args.Value,
			Version: 1,
		}
		reply.Err = rpc.OK

	case !exists:
		reply.Err = rpc.ErrNoKey

	case record.Version == args.Version:
		record.Value = args.Value
		record.Version++
		reply.Err = rpc.OK

	default:
		reply.Err = rpc.ErrVersion
	}
}

// You can ignore Kill() for this lab
func (kv *KVServer) Kill() {
}
// You can ignore all arguments; they are for replicated KVservers
func StartKVServer(ends []*labrpc.ClientEnd, gid tester.Tgid, srv int, persister *tester.Persister) []tester.IService {
	kv := MakeKVServer()
	return []tester.IService{kv}
}
