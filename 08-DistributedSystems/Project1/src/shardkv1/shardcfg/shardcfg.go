package shardcfg

import (
	"encoding/json"
	"hash/fnv"
	"log"
	"runtime/debug"
	"slices"
	"testing"

	"6.5840/tester1"
)

type Tshid int
type Tnum int

const (
	NShards  = 12 // The number of shards.
	NumFirst = Tnum(1)
)

const (
	Gid1 = tester.Tgid(1)
)

// which shard is a key in?
// please use this function,
// and please do not change it.
func Key2Shard(key string) Tshid {
	h := fnv.New32a()
	h.Write([]byte(key))
	shard := Tshid(Tshid(h.Sum32()) % NShards)
	return shard
}

// A configuration -- an assignment of shards to groups.
// Please don't change this.
type ShardConfig struct {
	Num    Tnum                     // config number
	Shards [NShards]tester.Tgid     // shard -> gid
	Groups map[tester.Tgid][]string // gid -> servers[]
}

func MakeShardConfig() *ShardConfig {
	c := &ShardConfig{
		Groups: make(map[tester.Tgid][]string),
	}
	return c
}

func (cfg *ShardConfig) String() string {
	b, err := json.Marshal(cfg)
	if err != nil {
		log.Fatalf("Unmarshall err %v", err)
	}
	return string(b)
}

func FromString(s string) *ShardConfig {
	scfg := &ShardConfig{}
	if err := json.Unmarshal([]byte(s), scfg); err != nil {
		log.Fatalf("Unmarshall err %v", err)
	}
	return scfg
}

func (cfg *ShardConfig) Copy() *ShardConfig {
	c := MakeShardConfig()
	c.Num = cfg.Num
	c.Shards = cfg.Shards
	for k, srvs := range cfg.Groups {
		s := make([]string, len(srvs))
		copy(s, srvs)
		c.Groups[k] = s
	}
	return c
}

// mostgroup, mostn, leastgroup, leastn
func analyze(c *ShardConfig) (tester.Tgid, int, tester.Tgid, int) {
	counts := map[tester.Tgid]int{}
	for _, g := range c.Shards {
		counts[g] += 1
	}

	mn := -1
	var mg tester.Tgid = -1
	ln := 257
	var lg tester.Tgid = -1
	// Enforce deterministic ordering, map iteration
	// is randomized in go
	groups := make([]tester.Tgid, len(c.Groups))
	i := 0
	for k := range c.Groups {
		groups[i] = k
		i++
	}
	slices.Sort(groups)
	for _, g := range groups {
		if counts[g] < ln {
			ln = counts[g]
			lg = g
		}
		if counts[g] > mn {
			mn = counts[g]
			mg = g
		}
	}

	return mg, mn, lg, ln
}

// return GID of group with least number of
// assigned shards.
func least(c *ShardConfig) tester.Tgid {
	_, _, lg, _ := analyze(c)
	return lg
}

// balance assignment of shards to groups.
// modifies c.
func (c *ShardConfig) Rebalance() {
	// if no groups, un-assign all shards
	if len(c.Groups) < 1 {
		for s, _ := range c.Shards {
			c.Shards[s] = 0
		}
		return
	}

	// assign all unassigned shards
	for s, g := range c.Shards {
		_, ok := c.Groups[g]
		if ok == false {
			lg := least(c)
			c.Shards[s] = lg
		}
	}

	// move shards from most to least heavily loaded
	for {
		mg, mn, lg, ln := analyze(c)
		if mn < ln+2 {
			break
		}
		// move 1 shard from mg to lg
		for s, g := range c.Shards {
			if g == mg {
				c.Shards[s] = lg
				break
			}
		}
	}
}

func (cfg *ShardConfig) Join(servers map[tester.Tgid][]string) bool {
	changed := false
	for gid, servers := range servers {
		_, ok := cfg.Groups[gid]
		if ok {
			log.Printf("re-Join %v", gid)
			return false
		}
		for xgid, xservers := range cfg.Groups {
			for _, s1 := range xservers {
				for _, s2 := range servers {
					if s1 == s2 {
						log.Fatalf("Join(%v) puts server %v in groups %v and %v", gid, s1, xgid, gid)
					}
				}
			}
		}
		// new GID
		// modify cfg to reflect the Join()
		cfg.Groups[gid] = servers
		changed = true
	}
	if changed == false {
		log.Fatalf("Join but no change")
	}
	cfg.Num += 1
	return true
}

func (cfg *ShardConfig) Leave(gids []tester.Tgid) bool {
	changed := false
	for _, gid := range gids {
		_, ok := cfg.Groups[gid]
		if ok == false {
			// already no GID!
			log.Printf("Leave(%v) but not in config", gid)
			return false
		} else {
			// modify op.Config to reflect the Leave()
			delete(cfg.Groups, gid)
			changed = true
		}
	}
	if changed == false {
		debug.PrintStack()
		log.Fatalf("Leave but no change")
	}
	cfg.Num += 1
	return true
}

func (cfg *ShardConfig) JoinBalance(servers map[tester.Tgid][]string) bool {
	if !cfg.Join(servers) {
		return false
	}
	cfg.Rebalance()
	return true
}

func (cfg *ShardConfig) LeaveBalance(gids []tester.Tgid) bool {
	if !cfg.Leave(gids) {
		return false
	}
	cfg.Rebalance()
	return true
}

func (cfg *ShardConfig) GidServers(sh Tshid) (tester.Tgid, []string, bool) {
	gid := cfg.Shards[sh]
	srvs, ok := cfg.Groups[gid]
	return gid, srvs, ok
}

func (cfg *ShardConfig) IsMember(gid tester.Tgid) bool {
	for _, g := range cfg.Shards {
		if g == gid {
			return true
		}
	}
	return false
}

func (cfg *ShardConfig) CheckConfig(t *testing.T, groups []tester.Tgid) {
	if len(cfg.Groups) != len(groups) {
		fatalf(t, "wanted %v groups, got %v", len(groups), len(cfg.Groups))
	}

	// are the groups as expected?
	for _, g := range groups {
		_, ok := cfg.Groups[g]
		if ok != true {
			fatalf(t, "missing group %v", g)
		}
	}

	// any un-allocated shards?
	if len(groups) > 0 {
		for s, g := range cfg.Shards {
			_, ok := cfg.Groups[g]
			if ok == false {
				fatalf(t, "shard %v -> invalid group %v", s, g)
			}
		}
	}

	// more or less balanced sharding?
	counts := map[tester.Tgid]int{}
	for _, g := range cfg.Shards {
		counts[g] += 1
	}
	min := 257
	max := 0
	for g, _ := range cfg.Groups {
		if counts[g] > max {
			max = counts[g]
		}
		if counts[g] < min {
			min = counts[g]
		}
	}
	if max > min+1 {
		fatalf(t, "max %v too much larger than min %v", max, min)
	}
}

func fatalf(t *testing.T, format string, args ...any) {
	debug.PrintStack()
	t.Fatalf(format, args...)
}
