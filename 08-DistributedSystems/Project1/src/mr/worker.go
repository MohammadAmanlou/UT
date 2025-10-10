package mr

import (
	"encoding/json"
	"fmt"
	"hash/fnv"
	"io"
	"log"
	"net/rpc"
	"os"
	"path/filepath"
	"time"
)

// Map functions return a slice of KeyValue.
type KeyValue struct {
	Key   string
	Value string
}

// use ihash(key) % NReduce to choose the reduce
// task number for each KeyValue emitted by Map.
func ihash(key string) int {
	h := fnv.New32a()
	h.Write([]byte(key))
	return int(h.Sum32() & 0x7fffffff)
}

// main/mrworker.go calls this function.
func Worker(mapf func(string, string) []KeyValue,
	reducef func(string, []string) string) {

	for {
		//fmt.Printf("Worker: requesting task...\n")
		task := RequestNewTask()
		if task.Type == NONE {
			break
		}
		if task == nil || task.Type == WAIT {
			time.Sleep(1 * time.Second)
			continue
		}
		var err error
		switch task.Type {
		case MAP:
			err = ExecuteMapTask(mapf, task.ID, task.FilePath, task.NReduce)
		case REDUCE:
			err = ExecuteReduceTask(reducef, task.ID)
		}
		if err == nil {
			ReportCompleteTask(task.ID, task.Type)
		}

	}
	// Your worker implementation here.

	// uncomment to send the Example RPC to the coordinator.
	// CallExample()

}

// example function to show how to make an RPC call to the coordinator.
//
// the RPC argument and reply types are defined in rpc.go.
func CallExample() {

	// declare an argument structure.
	args := ExampleArgs{}

	// fill in the argument(s).
	args.X = 99

	// declare a reply structure.
	reply := ExampleReply{}

	// send the RPC request, wait for the reply.
	// the "Coordinator.Example" tells the
	// receiving server that we'd like to call
	// the Example() method of struct Coordinator.
	ok := call("Coordinator.Example", &args, &reply)
	if ok {
		// reply.Y should be 100.
		fmt.Printf("reply.Y %v\n", reply.Y)
	} else {
		fmt.Printf("call failed!\n")
	}
}

// send an RPC request to the coordinator, wait for the response.
// usually returns true.
// returns false if something goes wrong.
func call(rpcname string, args interface{}, reply interface{}) bool {
	// c, err := rpc.DialHTTP("tcp", "127.0.0.1"+":1234")
	sockname := coordinatorSock()
	c, err := rpc.DialHTTP("unix", sockname)
	if err != nil {
		log.Fatal("dialing:", err)
	}
	defer c.Close()

	err = c.Call(rpcname, args, reply)
	if err == nil {
		return true
	}

	fmt.Println(err)
	return false
}

func RequestNewTask() *ResponseTaskArgs {
	args := RequestTaskArgs{}

	reply := ResponseTaskArgs{}

	ok := call("Coordinator.GetTask", &args, &reply)
	if ok {
		return &reply
	} else {
		return nil
	}
}

func ExecuteMapTask(mapf func(string, string) []KeyValue, id int, filePath string, nReduce int) error {
	file, err := os.Open(filePath)
	if err != nil {
		return fmt.Errorf("open input file: %w", err)
	}
	defer file.Close()

	content, err := io.ReadAll(file)
	if err != nil {
		return fmt.Errorf("read input file: %w", err)
	}

	intermediate := mapf(filePath, string(content))

	groups := make([][]KeyValue, nReduce)
	for _, kv := range intermediate {
		x := ihash(kv.Key) % nReduce
		groups[x] = append(groups[x], kv)
	}

	for x := 0; x < nReduce; x++ {
		tempFile, err := os.CreateTemp(".", "mr-temp-*.txt")
		if err != nil {
			return fmt.Errorf("create temp file: %w", err)
		}
		tempName := tempFile.Name()

		// defer func(name string) {
		// 	os.Remove(name)
		// }(tempName)

		enc := json.NewEncoder(tempFile)
		for _, kv := range groups[x] {
			if err := enc.Encode(&kv); err != nil {
				tempFile.Close()
				return fmt.Errorf("json encode: %w", err)
			}
		}

		if err := tempFile.Close(); err != nil {
			return fmt.Errorf("close temp file: %w", err)
		}

		finalName := fmt.Sprintf("mr-%d-%d.txt", id, x)
		if err := os.Rename(tempName, finalName); err != nil {
			return fmt.Errorf("rename temp file: %w", err)
		}
	}

	return nil
}

func ReadIntermediateFile(filename string, intermediate *map[string][]string) error {
	file, err := os.Open(filename)
	if err != nil {
		return fmt.Errorf("open input file: %w", err)
	}
	defer file.Close()

	dec := json.NewDecoder(file)
	for {
		var kv KeyValue
		err := dec.Decode(&kv)
		if err == io.EOF {
			break
		}
		if err != nil {
			return fmt.Errorf("error decoding %s: %w", filename, err)
		}

		(*intermediate)[kv.Key] = append((*intermediate)[kv.Key], kv.Value)
	}

	return nil
}

func ExecuteReduceTask(reducef func(string, []string) string, id int) error {
	pattern := fmt.Sprintf("mr-*-%d.txt", id)
	files, err := filepath.Glob(pattern)
	if err != nil {
		return fmt.Errorf("filepath: %w", err)
	}

	intermediate := make(map[string][]string)
	for _, filename := range files {
		err := ReadIntermediateFile(filename, &intermediate)
		if err != nil {
			return fmt.Errorf("error reading %s: %w", filename, err)
		}
	}

	//ofilename := fmt.Sprintf("mr-out-%d.txt", id)
	ofilename := fmt.Sprintf("mr-out-%d", id)
	ofile, err := os.Create(ofilename)
	if err != nil {
		return fmt.Errorf("create output file: %w", err)
	}
	defer ofile.Close()

	for key, values := range intermediate {
		output := reducef(key, values)
		fmt.Fprintf(ofile, "%v %v\n", key, output)
	}

	return nil
}

func ReportCompleteTask(id int, taskType TaskType) error {
	args := ReportTask{ID: id, Type: taskType}

	reply := ResponseReportTask{}

	ok := call("Coordinator.ReportCompletedTask", &args, &reply)
	//fmt.Printf("Reported completion of task %d of type %v\n", id, taskType)
	if !ok {
		return fmt.Errorf("reporting task %d failed", id)
	}
	return nil

}
