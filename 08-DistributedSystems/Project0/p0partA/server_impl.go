package p0partA

import (
	"bufio"
	"bytes"
	"fmt"
	"myMainproject/p0partA/kvstore"
	"net"
	"strconv"
)

type keyValueServer struct {
	store        kvstore.KVStore
	listener     net.Listener
	newConnChan  chan net.Conn
	dropConnChan chan int
	requestChan  chan Request
	clients      map[int]*client
	nextClientID int
	activeCount  int
	droppedCount int
	closeChan    chan struct{}
	doneChan     chan struct{}
}

type client struct {
	id      int
	conn    net.Conn
	outChan chan string
}

type Request struct {
	clientID int
	cmd      string
	key      []byte
	oldVal   []byte
	newVal   []byte
}

func New(store kvstore.KVStore) KeyValueServer {
	return &keyValueServer{
		store:        store,
		newConnChan:  make(chan net.Conn),
		dropConnChan: make(chan int),
		requestChan:  make(chan Request),
		clients:      make(map[int]*client),
		closeChan:    make(chan struct{}),
		doneChan:     make(chan struct{}),
	}
}

func (kvs *keyValueServer) Start(port int) error {
	ln, err := net.Listen("tcp", ":"+strconv.Itoa(port))
	if err != nil {
		return err
	}
	kvs.listener = ln
	go kvs.runServerLoop()
	go kvs.acceptLoop()
	return nil
}

func (kvs *keyValueServer) acceptLoop() {
	for {
		conn, err := kvs.listener.Accept()
		if err != nil {
			select {
			case <-kvs.closeChan:
				return
			default:
			}
			continue
		}
		select {
		case kvs.newConnChan <- conn:
		case <-kvs.closeChan:
			conn.Close()
			return
		}
	}
}

func (kvs *keyValueServer) runServerLoop() {
	for {
		select {
		case conn := <-kvs.newConnChan:
			kvs.handleNewConnection(conn)
		case req := <-kvs.requestChan:
			kvs.handleRequest(req)
		case cid := <-kvs.dropConnChan:
			kvs.handleDrop(cid)
		case <-kvs.closeChan:
			kvs.shutdown()
			close(kvs.doneChan)
			return
		}
	}
}

func (kvs *keyValueServer) handleNewConnection(conn net.Conn) {
	fmt.Println("New client connected:", conn.RemoteAddr())
	kvs.activeCount++
	cid := kvs.nextClientID
	kvs.nextClientID++

	c := &client{
		id:      cid,
		conn:    conn,
		outChan: make(chan string, 500),
	}
	kvs.clients[cid] = c

	go kvs.readLoop(c)
	go kvs.writeLoop(c)
}

func (kvs *keyValueServer) readLoop(cl *client) {
	defer func() {
		kvs.dropConnChan <- cl.id
		cl.conn.Close()
	}()

	reader := bufio.NewReader(cl.conn)
	for {
		line, err := reader.ReadBytes('\n')
		if err != nil {
			return
		}
		if len(line) > 0 && line[len(line)-1] == '\n' {
			line = line[:len(line)-1]
		}

		req, perr := parseLineToRequest(line, cl.id)
		if perr != nil {
			continue
		}
		select {
		case kvs.requestChan <- req:
		case <-kvs.closeChan:
			return
		}
	}
}

func (kvs *keyValueServer) writeLoop(cl *client) {
	defer cl.conn.Close()

	writer := bufio.NewWriter(cl.conn)
	for {
		select {
		case msg, ok := <-cl.outChan:
			if !ok {
				return
			}
			_, err := writer.WriteString(msg + "\n")
			if err != nil {
				kvs.dropConnChan <- cl.id
				return
			}
			writer.Flush()
		case <-kvs.closeChan:
			return
		}
	}
}

func (kvs *keyValueServer) handleRequest(req Request) {
	switch req.cmd {
	case "Put":
		kvs.store.Put(bytesToString(req.key), req.newVal)
	case "Get":
		values := kvs.store.Get(bytesToString(req.key))
		cl := kvs.clients[req.clientID]
		if cl == nil {
			return
		}
		for _, v := range values {
			line := bytesToString(req.key) + ":" + bytesToString(v)
			select {
			case cl.outChan <- line:
			default:
			}
		}
	case "Delete":
		kvs.store.Delete(bytesToString(req.key))
	case "Update":
		kvs.store.Update(bytesToString(req.key), req.oldVal, req.newVal)
	}
}

func (kvs *keyValueServer) handleDrop(clientID int) {
	c, ok := kvs.clients[clientID]
	if ok {
		delete(kvs.clients, clientID)
		close(c.outChan)
		kvs.droppedCount++
		kvs.activeCount--
	}
}

func (kvs *keyValueServer) shutdown() {
	for _, c := range kvs.clients {
		c.conn.Close()
		close(c.outChan)
	}
	kvs.clients = make(map[int]*client)
	kvs.listener.Close()
}

func (kvs *keyValueServer) Close() {
	select {
	case <-kvs.closeChan:
		return
	default:
		close(kvs.closeChan)
		kvs.listener.Close()
		<-kvs.doneChan
	}
}

func (kvs *keyValueServer) CountActive() int {
	return kvs.activeCount
}

func (kvs *keyValueServer) CountDropped() int {
	return kvs.droppedCount
}

func parseLineToRequest(line []byte, cid int) (Request, error) {
	tokens := splitByColon(line)
	if len(tokens) < 2 {
		return Request{}, fmt.Errorf("not enough tokens")
	}
	cmd := bytesToString(tokens[0])

	switch cmd {
	case "Put":
		if len(tokens) < 3 {
			return Request{}, fmt.Errorf("invalid Put command")
		}
		key := tokens[1]
		newVal := rejoinWithColon(tokens, 2)
		return Request{clientID: cid, cmd: "Put", key: key, newVal: newVal}, nil

	case "Get":
		if len(tokens) != 2 {
			return Request{}, fmt.Errorf("invalid Get command")
		}
		key := tokens[1]
		return Request{clientID: cid, cmd: "Get", key: key}, nil

	case "Delete":
		if len(tokens) != 2 {
			return Request{}, fmt.Errorf("invalid Delete command")
		}
		key := tokens[1]
		return Request{clientID: cid, cmd: "Delete", key: key}, nil

	case "Update":
		if len(tokens) < 4 {
			return Request{}, fmt.Errorf("invalid Update command")
		}
		key := tokens[1]
		oldVal := tokens[2]
		newVal := rejoinWithColon(tokens, 3)
		return Request{clientID: cid, cmd: "Update", key: key, oldVal: oldVal, newVal: newVal}, nil

	default:
		return Request{}, fmt.Errorf("unknown command")
	}
}

func splitByColon(line []byte) [][]byte {
	var result [][]byte
	start := 0
	for {
		idx := bytes.IndexByte(line[start:], ':')
		if idx < 0 {
			result = append(result, line[start:])
			break
		}
		piece := line[start : start+idx]
		result = append(result, piece)
		start += idx + 1
	}
	return result
}

func rejoinWithColon(tokens [][]byte, start int) []byte {
	if start >= len(tokens) {
		return nil
	}
	out := make([]byte, 0, len(tokens[start:]))
	for i := start; i < len(tokens); i++ {
		out = append(out, tokens[i]...)
		if i < len(tokens)-1 {
			out = append(out, ':')
		}
	}
	return out
}

func bytesToString(b []byte) string {
	return string(b)
}
