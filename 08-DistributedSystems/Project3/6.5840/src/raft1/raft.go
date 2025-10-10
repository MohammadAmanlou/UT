package raft

import (
	"bytes"
	"math/rand"
	"sync"
	"sync/atomic"
	"time"

	"6.5840/labgob"
	"6.5840/labrpc"
	"6.5840/raftapi"
	tester "6.5840/tester1"
)

const (
	follower  = 0
	candidate = 1
	leader    = 2
)

type LogEntry struct {
	Term    int
	Command interface{}
}

type RequestVoteArgs struct {
	Term         int
	CandidateId  int
	LastLogIndex int
	LastLogTerm  int
}

type RequestVoteReply struct {
	Term        int
	VoteGranted bool
}

type AppendEntriesArgs struct {
	Term         int
	LeaderId     int
	PrevLogIndex int
	PrevLogTerm  int
	Entries      []LogEntry
	LeaderCommit int
}

type AppendEntriesReply struct {
	Term          int
	Success       bool
	ConflictIndex int
	ConflictTerm  int
}

type InstallSnapshotArgs struct {
	Term              int
	LeaderId          int
	LastIncludedIndex int
	LastIncludedTerm  int
	Data              []byte
}

type InstallSnapshotReply struct{ 
	Term int 
}

type Raft struct {
	mu        sync.Mutex
	peers     []*labrpc.ClientEnd
	persister *tester.Persister
	me        int
	dead      int32

	currentTerm       int
	votedFor          int
	log               []LogEntry
	lastIncludedIndex int
	lastIncludedTerm  int

	commitIndex int
	lastApplied int

	nextIndex  []int
	matchIndex []int

	state             int
	applyCh           chan raftapi.ApplyMsg
	lastResetOfTicker time.Time
}

func (rf *Raft) slice(i int) int { 
	return i - rf.lastIncludedIndex 
}

func (rf *Raft) lastLogIndex() int { 
	return rf.lastIncludedIndex + len(rf.log) - 1 
}

func (rf *Raft) lastLogTerm() int { 
	return rf.log[len(rf.log)-1].Term 
}

func (rf *Raft) termAt(i int) int {
	if i == rf.lastIncludedIndex {
		return rf.lastIncludedTerm
	}
	return rf.log[rf.slice(i)].Term
}

func (rf *Raft) electionTimeout() time.Duration {
	return time.Duration(300+rand.Intn(200)) * time.Millisecond
}

func (rf *Raft) heartbeatInterval() time.Duration { 
	return 100 * time.Millisecond 
}

func (rf *Raft) resetTimer() { 
	rf.lastResetOfTicker = time.Now() 
}

func (rf *Raft) GetState() (int, bool) {
	rf.mu.Lock()
	defer rf.mu.Unlock()
	return rf.currentTerm, rf.state == leader
}

func (rf *Raft) saveStateAndSnapshot(snap []byte) {
    w := new(bytes.Buffer)
    e := labgob.NewEncoder(w)
    e.Encode(rf.currentTerm)
    e.Encode(rf.votedFor)
    e.Encode(rf.log)
    e.Encode(rf.lastIncludedIndex)
    e.Encode(rf.lastIncludedTerm)
    rf.persister.Save(w.Bytes(), snap)
}

func (rf *Raft) persist() {
    rf.saveStateAndSnapshot(rf.persister.ReadSnapshot())
}


func (rf *Raft) readPersist() {
    data := rf.persister.ReadRaftState()
    if len(data) > 0 {
        r := bytes.NewBuffer(data)
        d := labgob.NewDecoder(r)

        var ct, vf int
        var lg []LogEntry
        var li, lt int

        if d.Decode(&ct) != nil ||
           d.Decode(&vf) != nil ||
           d.Decode(&lg) != nil ||
           d.Decode(&li) != nil ||
           d.Decode(&lt) != nil {
            return
        }

        rf.currentTerm       = ct
        rf.votedFor          = vf
        rf.log               = lg
        rf.lastIncludedIndex = li
        rf.lastIncludedTerm  = lt

        rf.commitIndex = rf.lastIncludedIndex
        rf.lastApplied = rf.lastIncludedIndex
    }

    if snap := rf.persister.ReadSnapshot(); len(snap) > 0 {
        idx, term := rf.lastIncludedIndex, rf.lastIncludedTerm
        dataCopy := make([]byte, len(snap))
        copy(dataCopy, snap)
        go func() {
            rf.applyCh <- raftapi.ApplyMsg{
                SnapshotValid: true,
                Snapshot:      dataCopy,
                SnapshotIndex: idx,
                SnapshotTerm:  term,
            }
        }()
    }
}

func (rf *Raft) PersistBytes() int {
	rf.mu.Lock()
	defer rf.mu.Unlock()
	return rf.persister.RaftStateSize()
}

func (rf *Raft) Snapshot(index int, snapshot []byte) {
    rf.mu.Lock()
    defer rf.mu.Unlock()

    if index <= rf.lastIncludedIndex || index > rf.lastLogIndex() {
        return
    }

    term := rf.termAt(index)
    cut  := index - rf.lastIncludedIndex
    rf.log = append([]LogEntry{{Term: term}}, rf.log[cut+1:]...)

    rf.lastIncludedIndex, rf.lastIncludedTerm = index, term
    if rf.commitIndex < index {
        rf.commitIndex = index
    }
    if rf.lastApplied < index {
        rf.lastApplied = index
    }

    rf.saveStateAndSnapshot(snapshot)


    if rf.state == leader {
        last := rf.lastLogIndex()
        for i := range rf.peers {
            if rf.nextIndex[i] <= rf.lastIncludedIndex {
                rf.nextIndex[i] = rf.lastIncludedIndex
            }
            if rf.nextIndex[i] > last+1 {
                rf.nextIndex[i] = last + 1
            }
            if rf.matchIndex[i] < rf.lastIncludedIndex {
                rf.matchIndex[i] = rf.lastIncludedIndex
            }
            if rf.matchIndex[i] > last {
                rf.matchIndex[i] = last
            }
        }
    }
}

func (rf *Raft) RequestVote(a *RequestVoteArgs, r *RequestVoteReply) {
	rf.mu.Lock()
	defer rf.mu.Unlock()

	if a.Term < rf.currentTerm {
		r.Term = rf.currentTerm
		return
	}
	if a.Term > rf.currentTerm {
		rf.becomeFollower(a.Term)
	}
	upToDate := func() bool {
		if a.LastLogTerm != rf.lastLogTerm() {
			return a.LastLogTerm > rf.lastLogTerm()
		}
		return a.LastLogIndex >= rf.lastLogIndex()
	}()
	if (rf.votedFor == -1 || rf.votedFor == a.CandidateId) && upToDate {
		rf.votedFor = a.CandidateId
		rf.persist()
		rf.resetTimer()
		r.VoteGranted = true
	}
	r.Term = rf.currentTerm
}

func (rf *Raft) AppendEntries(a *AppendEntriesArgs, r *AppendEntriesReply) {
	rf.mu.Lock()
	defer rf.mu.Unlock()

	if a.Term < rf.currentTerm {
		r.Term = rf.currentTerm
		return
	}
	if a.Term > rf.currentTerm {
		rf.becomeFollower(a.Term)
	}
	rf.resetTimer()

	if a.PrevLogIndex < rf.lastIncludedIndex {
		r.ConflictIndex, r.ConflictTerm, r.Term = rf.lastIncludedIndex+1, -1, rf.currentTerm
		return
	}
	if a.PrevLogIndex > rf.lastLogIndex() {
		r.ConflictIndex, r.ConflictTerm, r.Term = rf.lastLogIndex()+1, -1, rf.currentTerm
		return
	}
	if rf.termAt(a.PrevLogIndex) != a.PrevLogTerm {
		ct := rf.termAt(a.PrevLogIndex)
		ci := a.PrevLogIndex
		for ci > rf.lastIncludedIndex && rf.termAt(ci-1) == ct {
			ci--
		}
		r.ConflictIndex, r.ConflictTerm, r.Term = ci, ct, rf.currentTerm
		return
	}

	if len(a.Entries) > 0 {
		rf.log = append(rf.log[:rf.slice(a.PrevLogIndex)+1], a.Entries...)
		rf.persist()
		if rf.commitIndex > rf.lastLogIndex() {
			rf.commitIndex = rf.lastLogIndex()
		}
	}

	if a.LeaderCommit > rf.commitIndex {
		if a.LeaderCommit < rf.lastLogIndex() {
			rf.commitIndex = a.LeaderCommit
		} else {
			rf.commitIndex = rf.lastLogIndex()
		}
	}
	r.Success, r.Term = true, rf.currentTerm
}

func (rf *Raft) InstallSnapshot(a *InstallSnapshotArgs, r *InstallSnapshotReply) {
	rf.mu.Lock()

	if a.Term < rf.currentTerm {
		r.Term = rf.currentTerm
		rf.mu.Unlock()
		return
	}
	if a.Term > rf.currentTerm {
		rf.becomeFollower(a.Term)
	}
	rf.resetTimer()
	r.Term = rf.currentTerm

	if a.LastIncludedIndex <= rf.lastIncludedIndex {
		rf.mu.Unlock()
		return
	}

	if a.LastIncludedIndex < rf.lastLogIndex() {
		pos := rf.slice(a.LastIncludedIndex) + 1
		rf.log = append([]LogEntry{{Term: a.LastIncludedTerm}}, rf.log[pos:]...)
	} else {
		rf.log = []LogEntry{{Term: a.LastIncludedTerm}}
	}
	rf.lastIncludedIndex, rf.lastIncludedTerm = a.LastIncludedIndex, a.LastIncludedTerm
	rf.commitIndex, rf.lastApplied = a.LastIncludedIndex, a.LastIncludedIndex
	rf.saveStateAndSnapshot(a.Data)

	apply := raftapi.ApplyMsg{
		SnapshotValid: true,
		Snapshot:      a.Data,
		SnapshotIndex: rf.lastIncludedIndex,
		SnapshotTerm:  rf.lastIncludedTerm,
	}

	rf.mu.Unlock()
	rf.applyCh <- apply
}

func (rf *Raft) sendInstallSnapshot(s int) {
	rf.mu.Lock()
	args := &InstallSnapshotArgs{
		Term:              rf.currentTerm,
		LeaderId:          rf.me,
		LastIncludedIndex: rf.lastIncludedIndex,
		LastIncludedTerm:  rf.lastIncludedTerm,
		Data:              rf.persister.ReadSnapshot(),
	}
	rf.mu.Unlock()
	reply := &InstallSnapshotReply{}
	if rf.peers[s].Call("Raft.InstallSnapshot", args, reply) {
		rf.mu.Lock()
		defer rf.mu.Unlock()
		if reply.Term > rf.currentTerm {
			rf.becomeFollower(reply.Term)
			return
		}
		rf.nextIndex[s] = rf.lastIncludedIndex + 1
		rf.matchIndex[s] = rf.lastIncludedIndex
	}
}

func (rf *Raft) sendAppendEntries(s int) {
	for !rf.killed() {
		rf.mu.Lock()
		if rf.state != leader {
			rf.mu.Unlock()
			return
		}
		if rf.nextIndex[s] <= rf.lastIncludedIndex {
			rf.mu.Unlock()
			rf.sendInstallSnapshot(s)
			return
		}
		next := rf.nextIndex[s]
		prev := next - 1
		args := &AppendEntriesArgs{
			Term:         rf.currentTerm,
			LeaderId:     rf.me,
			PrevLogIndex: prev,
			PrevLogTerm:  rf.termAt(prev),
			Entries:      append([]LogEntry(nil), rf.log[rf.slice(next):]...),
			LeaderCommit: rf.commitIndex,
		}
		rf.mu.Unlock()

		reply := &AppendEntriesReply{}
		ok := rf.peers[s].Call("Raft.AppendEntries", args, reply)

		rf.mu.Lock()
		if !ok || rf.state != leader || rf.currentTerm != args.Term {
			rf.mu.Unlock()
			return
		}
		if reply.Term > rf.currentTerm {
			rf.becomeFollower(reply.Term)
			rf.mu.Unlock()
			return
		}
		if reply.Success {
			rf.matchIndex[s] = args.PrevLogIndex + len(args.Entries)
			rf.nextIndex[s] = rf.matchIndex[s] + 1
			rf.advanceCommit()
			rf.mu.Unlock()
			return
		}
		if reply.ConflictTerm != -1 {
			j := rf.lastIncludedIndex
			for k := len(rf.log) - 1; k >= 0; k-- {
				if rf.log[k].Term == reply.ConflictTerm {
					j = rf.lastIncludedIndex + k
					break
				}
			}
			rf.nextIndex[s] = j + 1
		} else {
			rf.nextIndex[s] = reply.ConflictIndex
		}
		rf.mu.Unlock()
	}
}

func (rf *Raft) advanceCommit() {
	for N := rf.lastLogIndex(); N > rf.commitIndex; N-- {
		if rf.termAt(N) != rf.currentTerm {
			continue
		}
		count := 1
		for i := range rf.peers {
			if i != rf.me && rf.matchIndex[i] >= N {
				count++
			}
		}
		if count*2 > len(rf.peers) {
			rf.commitIndex = N
			break
		}
	}
}

func (rf *Raft) Start(cmd interface{}) (int, int, bool) {
	rf.mu.Lock()
	defer rf.mu.Unlock()
	if rf.state != leader {
		return -1, rf.currentTerm, false
	}
	rf.log = append(rf.log, LogEntry{Term: rf.currentTerm, Command: cmd})
	idx := rf.lastLogIndex()
	rf.matchIndex[rf.me], rf.nextIndex[rf.me] = idx, idx+1
	rf.persist()
	for i := range rf.peers {
		if i != rf.me {
			go rf.sendAppendEntries(i)
		}
	}
	return idx, rf.currentTerm, true
}

func (rf *Raft) Kill() { 
	atomic.StoreInt32(&rf.dead, 1) 
}

func (rf *Raft) killed() bool {
	return atomic.LoadInt32(&rf.dead) == 1
}

func (rf *Raft) applier() {
	for !rf.killed() {
		rf.mu.Lock()
		for rf.lastApplied < rf.commitIndex {
			rf.lastApplied++
			msg := raftapi.ApplyMsg{
				CommandValid: true,
				Command:      rf.log[rf.slice(rf.lastApplied)].Command,
				CommandIndex: rf.lastApplied,
			}
			rf.mu.Unlock()
			rf.applyCh <- msg
			rf.mu.Lock()
		}
		rf.mu.Unlock()
		time.Sleep(10 * time.Millisecond)
	}
}

func (rf *Raft) ticker() {
	for rf.killed() == false {
		rf.mu.Lock()
		elapsed := time.Since(rf.lastResetOfTicker)
		switch rf.state {
		case leader:
			if elapsed >= rf.heartbeatInterval() {
				for i := range rf.peers {
					if i != rf.me {
						go rf.sendAppendEntries(i)
					}
				}
				rf.resetTimer()
			}
		default:
			if elapsed >= rf.electionTimeout() {
				rf.startElection()
				rf.resetTimer()
			}
		}
		rf.mu.Unlock()
		ms := 50 + (rand.Int63() % 300)
		time.Sleep(time.Duration(ms) * time.Millisecond)
	}
}

func (rf *Raft) startElection() {
	rf.currentTerm++
	rf.state = candidate
	rf.votedFor = rf.me
	rf.persist()
	term := rf.currentTerm
	lastIdx, lastTerm := rf.lastLogIndex(), rf.lastLogTerm()

	votes := 1
	for i := range rf.peers {
		if i == rf.me {
			continue
		}
		go func(s int) {
			args := &RequestVoteArgs{
				Term:         term,
				CandidateId:  rf.me,
				LastLogIndex: lastIdx,
				LastLogTerm:  lastTerm,
			}
			reply := &RequestVoteReply{}
			if rf.peers[s].Call("Raft.RequestVote", args, reply) {
				rf.mu.Lock()
				defer rf.mu.Unlock()
				if rf.state != candidate || rf.currentTerm != term {
					return
				}
				if reply.Term > rf.currentTerm {
					rf.becomeFollower(reply.Term)
					return
				}
				if reply.VoteGranted {
					votes++
					if votes*2 > len(rf.peers) {
						rf.becomeLeader()
					}
				}
			}
		}(i)
	}
}

func (rf *Raft) becomeFollower(t int) {
	rf.state, rf.currentTerm, rf.votedFor = follower, t, -1
	rf.persist()
	rf.resetTimer()
}
func (rf *Raft) becomeLeader() {
	rf.state = leader
	for i := range rf.peers {
		rf.nextIndex[i] = rf.lastLogIndex() + 1
		rf.matchIndex[i] = rf.lastIncludedIndex
	}
	for i := range rf.peers {
		if i != rf.me {
			go rf.sendAppendEntries(i)
		}
	}
	rf.resetTimer()
}

func Make(peers []*labrpc.ClientEnd, me int,
	persister *tester.Persister, applyCh chan raftapi.ApplyMsg) raftapi.Raft {

	labgob.Register(LogEntry{})

	rf := &Raft{
		peers:      peers,
		persister:  persister,
		me:         me,
		state:      follower,
		votedFor:   -1,
		log:        []LogEntry{{Term: 0}},
		applyCh:    applyCh,
		nextIndex:  make([]int, len(peers)),
		matchIndex: make([]int, len(peers)),
	}
	rf.readPersist()
	rf.resetTimer()

	go rf.ticker()
	go rf.applier()

	return rf
}
