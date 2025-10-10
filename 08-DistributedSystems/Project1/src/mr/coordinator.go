package mr

import (
	"log"
	"net"
	"net/http"
	"net/rpc"
	"os"
	"sync"
	"time"
)

type TaskState int

const (
	TODO TaskState = iota
	ONGOING
	DONE
)

type TaskType int

const (
	MAP TaskType = iota
	REDUCE
	WAIT
	NONE
)

type Task struct {
	ID        int
	Type      TaskType
	Status    TaskState
	FilePath  string
	StartTime time.Time
}

func (t *Task) IsExpired() bool {
	if t.StartTime.IsZero() {
		return false
	}
	return !t.StartTime.IsZero() && time.Since(t.StartTime) > 10*time.Second
}

type Coordinator struct {
	// Your definitions here.
	NReduce     int
	mapTasks    map[int]*Task
	reduceTasks map[int]*Task
	mu          sync.Mutex
}

// Your code here -- RPC handlers for the worker to call.

// an example RPC handler.
//
// the RPC argument and reply types are defined in rpc.go.
func (c *Coordinator) Example(args *ExampleArgs, reply *ExampleReply) error {
	reply.Y = args.X + 1
	return nil
}

// start a thread that listens for RPCs from worker.go
func (c *Coordinator) server() {
	rpc.Register(c)
	rpc.HandleHTTP()
	//l, e := net.Listen("tcp", ":1234")
	sockname := coordinatorSock()
	os.Remove(sockname)
	l, e := net.Listen("unix", sockname)
	if e != nil {
		log.Fatal("listen error:", e)
	}
	go http.Serve(l, nil)
}

// main/mrcoordinator.go calls Done() periodically to find out
// if the entire job has finished.
func (c *Coordinator) Done() bool {
	c.mu.Lock()
	defer c.mu.Unlock()
	//fmt.Printf("Remaining MAP tasks: %d, REDUCE tasks: %d\n", len(c.mapTasks), len(c.reduceTasks))
	ret := len(c.mapTasks) == 0 && len(c.reduceTasks) == 0
	return ret
}

// create a Coordinator.
// main/mrcoordinator.go calls this function.
// nReduce is the number of reduce tasks to use.

func (c *Coordinator) RescheduleExpiredTasks() {
	c.mu.Lock()
	defer c.mu.Unlock()

	for _, task := range c.mapTasks {
		if task.Status == ONGOING && task.IsExpired() {
			task.Status = TODO
			task.StartTime = time.Time{}
		}
	}

	for _, task := range c.reduceTasks {
		if task.Status == ONGOING && task.IsExpired() {
			task.Status = TODO
			task.StartTime = time.Time{}
		}
	}
}

func (c *Coordinator) GetTask(args *RequestTaskArgs, reply *ResponseTaskArgs) error {
	c.RescheduleExpiredTasks()

	c.mu.Lock()
	defer c.mu.Unlock()

	reply.Type = WAIT

	mapTasksCompleted := len(c.mapTasks) == 0
	reduceTasksCompleted := len(c.reduceTasks) == 0
	var selectedTask *Task
	if mapTasksCompleted && reduceTasksCompleted {
		reply.Type = NONE
		return nil
	}

	if !mapTasksCompleted {
		for _, task := range c.mapTasks {
			if task.Status == TODO {
				selectedTask = task
				break
			}
		}
	} else {
		for _, task := range c.reduceTasks {
			if task.Status == TODO {
				selectedTask = task
				break
			}
		}
	}

	if selectedTask != nil {
		reply.ID = selectedTask.ID
		reply.Type = selectedTask.Type
		reply.NReduce = c.NReduce

		if selectedTask.Type == MAP {
			reply.FilePath = selectedTask.FilePath
		}

		selectedTask.Status = ONGOING
		selectedTask.StartTime = time.Now()

		//fmt.Printf("Coordinator: assigned task ID=%d Type=%v\n", selectedTask.ID, selectedTask.Type)
	}

	return nil
}

func (c *Coordinator) ReportCompletedTask(args *ReportTask, reply *ResponseReportTask) error {
	c.mu.Lock()
	defer c.mu.Unlock()
	//fmt.Printf("Received completion report: ID=%d, Type=%v\n", args.ID, args.Type)
	switch args.Type {
	case MAP:
		if _, exists := c.mapTasks[args.ID]; exists {
			delete(c.mapTasks, args.ID)
		}
	case REDUCE:
		if _, exists := c.reduceTasks[args.ID]; exists {
			delete(c.reduceTasks, args.ID)
		}
	}
	//fmt.Printf("Coordinator: received completed task ID=%d Type=%v\n", args.ID, args.Type)
	return nil
}

func MakeCoordinator(files []string, nReduce int) *Coordinator {
	c := Coordinator{
		NReduce:     nReduce,
		mapTasks:    make(map[int]*Task),
		reduceTasks: make(map[int]*Task),
	}

	// Your code here.

	for index, file := range files {
		c.mapTasks[index] = &Task{
			ID:       index,
			Type:     MAP,
			Status:   TODO,
			FilePath: file,
		}
	}

	for index := range nReduce {
		c.reduceTasks[index] = &Task{
			ID:     index,
			Type:   REDUCE,
			Status: TODO,
		}
	}

	c.server()
	return &c
}
