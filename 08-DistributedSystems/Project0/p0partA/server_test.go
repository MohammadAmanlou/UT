// Official tests for a KeyValueServer implementation.

package p0partA

import (
	"bufio"
	"bytes"
	"container/list"
	"errors"
	"fmt"
	"math/rand"
	"myMainproject/p0partA/kvstore"
	"net"
	"strconv"
	"strings"
	"syscall"
	"testing"
	"time"
)

const (
	defaultStartDelay = 500
	startServerTries  = 5
	largeMsgSize      = 4096
	putFreq           = 3
	updateFreq        = 5
	keyFactor         = 10
)
const allLetters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

// This helper function generates a random string that is used to inflate the
// size of messages sent to slow reader clients (thus, making it more likely
// that the server will block on 'Write' and causing messages to be dropped).
func generateRandomString() string {
	largeByteSlice := make([]byte, largeMsgSize)
	for i := range largeByteSlice {
		largeByteSlice[i] = allLetters[rand.Int63()%int64(len(allLetters))]
	}
	return string(largeByteSlice)
}

var largeByteSlice = generateRandomString()

type testSystem struct {
	store    kvstore.KVStore
	internal map[string][]([]byte)
	test     *testing.T     // Pointer to the current test case being run.
	server   KeyValueServer // The student's server implementation.
	hostport string         // The server's host/port address.
}

type testClient struct {
	id   int      // A unique id identifying this client.
	conn net.Conn // The client's TCP connection.
	slow bool     // True iff this client reads struct slowly.
}

type networkEvent struct {
	cli      *testClient // The client that received a network event.
	readMsg  string      // The message read from the network.
	writeMsg string      // The message to write to the network.
	err      error       // Notifies us that an error has occurred (if non-nil).
}

// countEvent is used to describe a round in CountActive tests.
type countEvent struct {
	start int // # of connections to start in a round.
	kill  int // # of connections to kill in a round.
	delay int // Wait time in ms before the next round begins.
}

func newTestSystem(t *testing.T) *testSystem {
	kvs, backdoor := kvstore.CreateWithBackdoor()
	return &testSystem{store: kvs, internal: backdoor, test: t}
}

func newTestClients(num int, slow bool) []*testClient {
	clients := make([]*testClient, num)
	for i := range clients {
		clients[i] = &testClient{id: i, slow: slow}
	}
	return clients
}

// startServer attempts to start a server on a random port, retrying up to numTries
// times if necessary. A non-nil error is returned if the server failed to start.
func (ts *testSystem) startServer(numTries int) error {
	randGen := rand.New(rand.NewSource(time.Now().Unix()))
	var err error
	for i := 0; i < numTries; i++ {
		ts.server = New(ts.store)
		if ts.server == nil {
			return errors.New("server returned by New() must not be nil")
		}
		port := 2000 + randGen.Intn(10000)
		if err = ts.server.Start(port); err == nil {
			ts.hostport = net.JoinHostPort("localhost", strconv.Itoa(port))
			return nil
		}
		if ts.internal == nil {
			return errors.New("db must be initialized after call to Start()")
		}
		fmt.Printf("Warning! Failed to start server on port %d: %s.\n", port, err)
		time.Sleep(time.Duration(50) * time.Millisecond)

	}
	if err != nil {
		return fmt.Errorf("failed to start server after %d tries", numTries)
	}
	return nil
}

// startClients connects the specified clients with the server, and returns a
// non-nil error if one or more of the clients failed to establish a connection.
func (ts *testSystem) startClients(clients ...*testClient) error {
	for _, cli := range clients {
		if addr, err := net.ResolveTCPAddr("tcp", ts.hostport); err != nil {
			return err
		} else if conn, err := net.DialTCP("tcp", nil, addr); err != nil {
			return err
		} else {
			cli.conn = conn
		}
	}
	return nil
}

// killClients kills the specified clients (i.e. closes their connections).
func (ts *testSystem) killClients(clients ...*testClient) {
	for i := range clients {
		cli := clients[i]
		if cli != nil && cli.conn != nil {
			cli.conn.Close()
		}
	}
}

// startReading signals the specified clients to begin reading from the network.
// Messages read over the network are sent back to the test runner through the
// readChan channel.
func (ts *testSystem) startReading(readChan chan<- *networkEvent,
	clients ...*testClient) {
	for _, cli := range clients {
		// Create new instance of cli for the goroutine
		// (see http://golang.org/doc/effective_go.html#channels).

		cli := cli
		go func() {
			reader := bufio.NewReader(cli.conn)
			for {
				// Read up to and including the first '\n' character.
				msgBytes, err := reader.ReadBytes('\n')
				if err != nil {
					readChan <- &networkEvent{err: err}
					return
				}
				// Notify the test runner that a message was read
				// from the network.
				readChan <- &networkEvent{
					cli:     cli,
					readMsg: string(msgBytes),
				}
			}
		}()
	}
}

// startWriting signals the specified clients to begin writing to the network. In order
// to ensure that reads/writes are synchronized, messages are sent to and written in
// the main test runner event loop.
func (ts *testSystem) startWriting(writeChan chan<- *networkEvent, numMsgs int,
	clients ...*testClient) {
	for _, cli := range clients {
		// Create new instance of cli for the goroutine
		// (see http://golang.org/doc/effective_go.html#channels).
		cli := cli
		go func() {
			// Client and message IDs guarantee that msgs sent over the network are unique.
			for msgID := 0; msgID < numMsgs; msgID++ {

				// Notify the test runner that a message should be written to the network.
				writeChan <- &networkEvent{
					cli: cli,
				}

				if msgID%100 == 0 {
					// Give readers some time to consume message before writing
					// the next batch of messages.
					time.Sleep(time.Duration(100) * time.Millisecond)
				}
			}
		}()
	}
}

// Helper test method that verifies that the expected contents exactly match the actual kvstore
func (ts *testSystem) checkDatabase(expected map[string][]([]byte)) error {
	// Check all of expected is in actual
	for k, v1 := range expected {
		v2, ok := ts.internal[k]
		if !ok {
			return fmt.Errorf("the db (kvstore) does not have an expected key, \"%v\"", k)
		} else if !bytesArraysEqual(v1, v2) {
			return fmt.Errorf("the db (kvstore) key, \"%v\", has the wrong value", k)
		}
	}

	// Check all of actual is in expected
	for k, v1 := range ts.internal {
		v2, ok := expected[k]
		if !ok {
			return fmt.Errorf("the db (kvstore) has an unexpected key, \"%v\"", k)
		} else if !bytesArraysEqual(v1, v2) {
			return fmt.Errorf("the db (kvstore) key, \"%v\", has the wrong value", k)
		}
	}

	return nil
}

// Helper method to check equality for two arrays of byte arrays (by casting []byte to string values)
func bytesArraysEqual(arr1, arr2 []([]byte)) bool {
	if len(arr1) != len(arr2) {
		return false
	}

	for i := 0; i < len(arr1); i++ {
		// Trim optional '\n' endings
		str1 := string(bytes.Trim(arr1[i], "\n"))
		str2 := string(bytes.Trim(arr2[i], "\n"))

		if str1 != str2 {
			return false
		}
	}

	return true
}

// Helper method to convert kvstore of []string to []([]byte) for comparison
func stringToBytesKvStore(keyValueMap map[string][]string) map[string][]([]byte) {
	result := make(map[string][]([]byte))

	// Iterate through each []string in the map and replace with []([]byte)
	for k, v := range keyValueMap {
		for _, s := range v {
			if _, ok := result[k]; !ok {
				result[k] = make([]([]byte), 1)
				result[k][0] = ([]byte)(s)
			} else {
				result[k] = append(result[k], ([]byte)(s))
			}
		}
	}
	return result
}

// Helper method to get a random key from a map, for delete test purposes
func getRandomKey(m map[string][]string) string {
	for k := range m {
		return k
	}
	return ""
}

// Main test routine for basic tests
// Each read/write cycle is done by doing a 'Put', a 'Delete' (if necessary), and a 'Put'
func (ts *testSystem) runTest(numMsgs, numDeletes, timeout int, normalClients, slowClients []*testClient, slowDelay int) error {
	numNormalClients := len(normalClients)
	numSlowClients := len(slowClients)
	numClients := numNormalClients + numSlowClients
	hasSlowClients := numSlowClients != 0

	totalGetWrites := numMsgs * numClients
	totalReads := 0
	totalNonSlowReads := 0
	normalReads, normalGetWrites := 0, 0
	slowReads, slowGetWrites := 0, 0
	totalDeletes := 0

	numKeys := numMsgs / keyFactor

	// start random number generator
	randGen := rand.New(rand.NewSource(time.Now().Unix()))

	keyMap := make(map[string]int)           // Number of messages sent per key
	keyValueMap := make(map[string][]string) // Expected database contents
	keyValueTrackMap := make(map[string]int) // Counter for each (k,v) pair sent
	readChan, writeChan := make(chan *networkEvent), make(chan *networkEvent)

	// Begin writing in the background (one goroutine per client).
	fmt.Println("All clients beginning to write...")
	ts.startWriting(writeChan, numMsgs, normalClients...)
	if hasSlowClients {
		ts.startWriting(writeChan, numMsgs, slowClients...)
	}

	// Begin reading in the background (one goroutine per client).
	ts.startReading(readChan, normalClients...)
	if hasSlowClients {
		fmt.Println("Normal clients beginning to read...")
		time.AfterFunc(time.Duration(slowDelay)*time.Millisecond, func() {
			fmt.Println("Slow clients beginning to read...")
			ts.startReading(readChan, slowClients...)
		})
	} else {
		fmt.Println("All clients beginning to read...")
	}

	// Returns a channel that will be sent a notification if a timeout occurs.
	timeoutChan := time.After(time.Duration(timeout) * time.Millisecond)

	// Main test runner loop to do reads/writes until completion (or until timeout)
	for slowReads+normalReads < totalReads ||
		slowGetWrites+normalGetWrites < totalGetWrites-numDeletes {

		select {
		case cmd := <-readChan:
			cli, msg := cmd.cli, cmd.readMsg
			if cmd.err != nil {
				return cmd.err
			}

			// Verify this kv-pair is being read the correct number of times
			if v, ok := keyValueTrackMap[msg]; !ok {
				if keyCount := keyMap[msg]; keyCount == 0 {
					return fmt.Errorf("client should have deleted: %s", msg)
				}

				// Abort! Client received a message that was never sent.
				return fmt.Errorf("client read unexpected message: %s", msg)
			} else if v > 1 {
				// We expect the message to be read v - 1 more times.
				keyValueTrackMap[msg] = v - 1
			} else {
				// The message has been read for the last time.
				// Erase it from memory.
				delete(keyValueTrackMap, msg)
			}
			if hasSlowClients && cli.slow {
				slowReads++
			} else {
				normalReads++
			}

		case cmd := <-writeChan:
			// Make Put request =======================================================================================

			var key, queryMsg string
			// Synchronizing writes is necessary because messages are read
			// concurrently in a background goroutine.
			cli := cmd.cli

			// generate a key unique for a client, special handling for slow clients
			if !cli.slow {
				key = fmt.Sprintf("key_%d_%d", cli.id, randGen.Intn(numKeys))
			} else {
				key = fmt.Sprintf("key_slow_%d_%d", cli.id,
					randGen.Intn(numKeys))
			}

			keySendCount, ok := keyMap[key]
			if !ok {
				keyMap[key] = 0
				keySendCount = 0
			}

			// Send a new 'chat message' every putFreq (new string to append to key)
			valueID := keySendCount / putFreq
			if keySendCount%putFreq == 0 {
				keyMap[key]++
				_, ok := keyValueMap[key]
				if !ok {
					keyValueMap[key] = make([]string, 0)
				}
				var value string
				if !hasSlowClients {
					value = fmt.Sprintf("value_%d\n", valueID)
				} else {
					// Inflate the value to increase the likelihood that
					// messages will be dropped due to slow clients.
					value = fmt.Sprintf("value_%s%d\n", largeByteSlice, valueID)
				}
				keyValueMap[key] = append(keyValueMap[key], value)
				queryMsg = fmt.Sprintf("Put:%s:%s", key, value)

				// send a Put message at putFreq interval and return
				if _, err := cli.conn.Write([]byte(queryMsg)); err != nil {
					return err
				}
			} else {
				// Make an Update query only if the current key was used before
				if ok {
					// Get a random value from the message lists for the current key
					existingVals := keyValueMap[key]
					numVals := len(existingVals)
					randomIndex := randGen.Intn(numVals)
					oldVal := existingVals[randomIndex]
					oldValCleaned := strings.TrimSpace(oldVal)
					defaultLen := len("value_")
					var newVal string
					if !hasSlowClients {
						// Construct a new value to replace the old value
						oldValIDStr := oldValCleaned[defaultLen:]
						oldValID, _ := strconv.Atoi(oldValIDStr)
						newValID := oldValID + numKeys
						newVal = fmt.Sprintf("value_%d\n", newValID)
					} else {
						// Construct a new value to replace the old value
						oldValIDStr := oldValCleaned[defaultLen+largeMsgSize:]
						oldValID, _ := strconv.Atoi(oldValIDStr)
						newValID := oldValID + numKeys
						// Inflate the value to increase the likelihood that
						// messages will be dropped due to slow clients.
						newVal = fmt.Sprintf("value_%s%d\n", largeByteSlice, newValID)
					}

					// Update the keyValueMap to reflect the update operation
					keyValueMap[key] = append(existingVals[:randomIndex], existingVals[randomIndex+1:]...)
					keyValueMap[key] = append(keyValueMap[key], newVal)
					queryMsg = fmt.Sprintf("Update:%s:%s:%s", key, oldValCleaned, newVal)

					if _, err := cli.conn.Write([]byte(queryMsg)); err != nil {
						return err
					}
				}
			}

			if totalDeletes < numDeletes {
				// Make Delete request ================================================================================

				// Get a random key to delete
				keyToDelete := getRandomKey(keyValueMap)

				// Update book-keeping for testing (as if the 'Put' request was never made)
				delete(keyMap, keyToDelete)
				delete(keyValueMap, keyToDelete)

				// Send a Delete request
				request := fmt.Sprintf("Delete:%s\n", keyToDelete)
				if _, err := cli.conn.Write([]byte(request)); err != nil {
					// Abort! Error writing to the network.
					return err
				}

				totalDeletes++
			} else {
				// Make GET request ===================================================================================

				totalReads += keyMap[key]
				if !cli.slow {
					totalNonSlowReads += keyMap[key]
				}

				request := fmt.Sprintf("Get:%s\n", key)

				for _, v := range keyValueMap[key] {
					keyValue := fmt.Sprintf("%s:%s", key, v)
					if _, ok := keyValueTrackMap[keyValue]; !ok {
						keyValueTrackMap[keyValue] = 1
					} else {
						keyValueTrackMap[keyValue]++
					}
				}

				if _, err := cli.conn.Write([]byte(request)); err != nil {
					// Abort! Error writing to the network.
					return err
				}
				if hasSlowClients && cli.slow {
					slowGetWrites++
				} else {
					normalGetWrites++
				}
			}

		case <-timeoutChan:
			if hasSlowClients {
				if normalReads != totalNonSlowReads {
					// Make sure non-slow clients received all written messages.
					return fmt.Errorf("non-slow clients received %d messages, expected %d",
						normalReads, totalNonSlowReads)
				}
				if slowReads < 500 {
					// Make sure the server buffered 500 messages for
					// slow-reading clients.
					return errors.New("slow-reading client read less than 500 messages")
				}
				return nil
			}
			// Otherwise, if there are no slow clients, then no messages
			// should be dropped and the test should NOT timeout.
			return errors.New("test timed out")
		}
	}

	if hasSlowClients {
		// If there are slow clients, then at least some messages
		// should have been dropped.
		return errors.New("no messages were dropped by slow clients")
	}

	// Verify database contents at the very end
	if err := ts.checkDatabase(stringToBytesKvStore(keyValueMap)); err != nil {
		return err
	}

	return nil
}

func (ts *testSystem) checkCountActive(expected int) error {
	if count := ts.server.CountActive(); count != expected {
		return fmt.Errorf("CountActive returned an incorrect value (returned %d, expected %d)",
			count, expected)
	}
	return nil
}

func (ts *testSystem) checkCountDropped(expected int) error {
	if count := ts.server.CountDropped(); count != expected {
		return fmt.Errorf("CountDropped count returned an incorrect value (returned %d, expected %d)",
			count, expected)
	}
	return nil
}

func testBasic(t *testing.T, name string, numClients, numMessages, numDeletes, timeout int) {
	syscall.Getrlimit(syscall.RLIMIT_NOFILE, &syscall.Rlimit{Cur: 64000, Max: 64000})
	fmt.Printf("========== %s: %d client(s), %d Get, %d Delete requests each ==========\n", name, numClients, numMessages-numDeletes, numDeletes)

	ts := newTestSystem(t)
	if err := ts.startServer(startServerTries); err != nil {
		t.Errorf("Failed to start server: %s\n", err)
		return
	}
	defer ts.server.Close()

	if err := ts.checkCountActive(0); err != nil {
		t.Error(err)
		return
	}

	allClients := newTestClients(numClients, false)
	if err := ts.startClients(allClients...); err != nil {
		t.Errorf("Failed to start clients: %s\n", err)
		return
	}
	defer ts.killClients(allClients...)

	// Give the server some time to register the clients before running the test.
	time.Sleep(time.Duration(defaultStartDelay) * time.Millisecond)

	if err := ts.checkCountActive(numClients); err != nil {
		t.Error(err)
		return
	}

	if err := ts.runTest(numMessages, numDeletes, timeout, allClients, []*testClient{}, 0); err != nil {
		t.Error(err)
		return
	}

}

func testSlowClient(t *testing.T, name string, numMessages, numDeletes, numSlowClients, numNormalClients, slowDelay, timeout int) {
	syscall.Getrlimit(syscall.RLIMIT_NOFILE, &syscall.Rlimit{Cur: 64000, Max: 64000})
	fmt.Printf("========== %s: %d total clients, %d slow client(s), %d Get, %d Delete requests each ==========\n",
		name, numSlowClients+numNormalClients, numSlowClients, numMessages-numDeletes, numDeletes)

	ts := newTestSystem(t)
	if err := ts.startServer(startServerTries); err != nil {
		t.Errorf("Failed to start server: %s\n", err)
		return
	}
	defer ts.server.Close()

	slowClients := newTestClients(numSlowClients, true)
	if err := ts.startClients(slowClients...); err != nil {
		t.Errorf("Test failed: %s\n", err)
		return
	}
	defer ts.killClients(slowClients...)
	normalClients := newTestClients(numNormalClients, false)
	if err := ts.startClients(normalClients...); err != nil {
		t.Errorf("Test failed: %s\n", err)
		return
	}
	defer ts.killClients(normalClients...)

	// Give the server some time to register the clients before running the test.
	time.Sleep(time.Duration(defaultStartDelay) * time.Millisecond)

	if err := ts.runTest(numMessages, numDeletes, timeout, normalClients, slowClients, slowDelay); err != nil {
		t.Error(err)
		return
	}
}

func (ts *testSystem) runCountTest(events []*countEvent, timeout int) {
	t := ts.test

	// Use a linked list to store a queue of clients.
	clients := list.New()
	defer func() {
		for clients.Front() != nil {
			ts.killClients(clients.Remove(clients.Front()).(*testClient))
		}
	}()

	// CountActive() should return 0 at the beginning of a count test.
	if err := ts.checkCountActive(0); err != nil {
		t.Error(err)
		return
	}

	// CountDropped() should return 0 at the beginning of a count test.
	if err := ts.checkCountDropped(0); err != nil {
		t.Error(err)
		return
	}

	timeoutChan := time.After(time.Duration(timeout) * time.Millisecond)

	totalKilled := 0
	for i, e := range events {
		fmt.Printf("Round %d: starting %d, killing %d\n", i+1, e.start, e.kill)
		for j := 0; j < e.start; j++ {
			// Create and start a new client, and add it to our
			// queue of clients.
			cli := new(testClient)
			if err := ts.startClients(cli); err != nil {
				t.Errorf("Failed to start clients: %s\n", err)
				return
			}
			clients.PushBack(cli)
		}
		for j := 0; j < e.kill; j++ {
			// Close the client's TCP connection with the server and
			// and remove it from the queue.
			cli := clients.Remove(clients.Front()).(*testClient)
			ts.killClients(cli)
		}
		select {
		case <-time.After(time.Duration(e.delay) * time.Millisecond):
			// Continue to the next round...
		case <-timeoutChan:
			t.Errorf("Test timed out.")
			return
		}

		totalKilled += e.kill

		if err := ts.checkCountActive(clients.Len()); err != nil {
			t.Errorf("Test failed during the event #%d: %s\n", i+1, err)
			return
		}
		if err := ts.checkCountDropped(totalKilled); err != nil {
			t.Errorf("Test failed during the event #%d: %s\n", i+1, err)
			return
		}
	}
}

func testCount(t *testing.T, name string, timeout int, max int, events ...*countEvent) {
	syscall.Getrlimit(syscall.RLIMIT_NOFILE, &syscall.Rlimit{Cur: 64000, Max: 64000})
	fmt.Printf("========== %s: %d rounds, up to %d clients started/killed per round ==========\n",
		name, len(events), max)

	ts := newTestSystem(t)
	if err := ts.startServer(startServerTries); err != nil {
		t.Errorf("Failed to start server: %s\n", err)
		return
	}
	defer ts.server.Close()

	// Give the server some time to register the clients before running the test.
	time.Sleep(time.Duration(defaultStartDelay) * time.Millisecond)

	ts.runCountTest(events, timeout)
}

func TestBasic1(t *testing.T) {
	testBasic(t, "TestBasic1", 1, 100, 10, 5000)
}

func TestBasic2(t *testing.T) {
	testBasic(t, "TestBasic2", 1, 1500, 50, 10000)
}

func TestBasic3(t *testing.T) {
	testBasic(t, "TestBasic3", 2, 20, 5, 5000)
}

func TestBasic4(t *testing.T) {
	testBasic(t, "TestBasic4", 2, 1500, 50, 10000)
}

func TestBasic5(t *testing.T) {
	testBasic(t, "TestBasic5", 5, 50, 5, 10000)
}

func TestBasic6(t *testing.T) {
	testBasic(t, "TestBasic6", 10, 1500, 50, 10000)
}

func TestCount1(t *testing.T) {
	testCount(t, "TestCount1", 5000, 20,
		&countEvent{start: 20, kill: 0, delay: 1000},
		&countEvent{start: 20, kill: 20, delay: 1000},
		&countEvent{start: 0, kill: 20, delay: 1000},
	)
}

func TestCount2(t *testing.T) {
	testCount(t, "TestCount2", 15000, 50,
		&countEvent{start: 15, kill: 0, delay: 1000},
		&countEvent{start: 25, kill: 25, delay: 1000},
		&countEvent{start: 45, kill: 35, delay: 1000},
		&countEvent{start: 50, kill: 35, delay: 1000},
		&countEvent{start: 30, kill: 1, delay: 1000},
		&countEvent{start: 0, kill: 15, delay: 1000},
		&countEvent{start: 0, kill: 20, delay: 1000},
	)
}

func TestSlowClient1(t *testing.T) {
	testSlowClient(t, "TestSlowClient1", 2000, 100, 1, 1, 5000, 10000)
}

func TestSlowClient2(t *testing.T) {
	testSlowClient(t, "TestSlowClient2", 2000, 100, 4, 2, 6000, 12000)
}
