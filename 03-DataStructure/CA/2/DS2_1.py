import sys

class Queue:
    def __init__(self):
        self.size = 0
        self.front = None
        self.rear = None

    def getSize(self):
        return (self.size)

    def enqueue(self, value):
        if (self.rear == None):
            r = Node(value)
            r.value = value
            r.next = None
            self.rear = r 
            self.front = self.rear
            self.size +=1
        else:
            p = Node(value)
            p.value = value
            self.rear.next = p 
            self.rear = p 
            self.size += 1

    def dequeue(self):
        if (self.front == None):
            return
        else:
            x = self.front.value
            self.front = self.front.next 
            self.size -= 1
            return (x)

    def isEmpty(self):
        if (self.size == 0):
            return (True)
        else:
            return (False)

    def getInOneLine(self):
        f = self.front
        l = ""
        while(f != None):
            l += (str(f.value) + " " )
            f = f.next
        print(l)

class Stack:
    def __init__(self, size=10):
        self.data = []
        self.size = size

    def isEmpty(self):
        if (len (self.data) == 0 ):
            return (True)
        else:
            return(False)

    def push(self, value):
        if (len(self.data) < self.size):
            self.data.append(value)
        else :
            return

    def pop(self):
        x = self.data[-1]
        self.data.pop(-1)
        return (x)

    def put(self,value):
        self.data.pop(-1)
        self.data.append(value)

    def peek(self):
        return(self.data[-1])

    def expand(self):
        self.size *= 2

    def getInOneLine(self):
        l = ""
        for i in self.data :
            l+=(str(i) + " ")
        return (l)

    def getSize(self):
        return(len(self.data))
    
    def getCapacity(self):
        return(self.size)

class Node():
    def __init__(self, val):
        self.value = val
        self.next = None
        self.prev = None

class LinkedList():
    def __init__(self):
        self.first = None
        self.last = None
    
    def getList(self):
        f = self.first
        l = ""
        while(f != None):
            l += (str(f.value) + " " )
            f = f.next
        print(l)
    
    def insertFront(self, new_data):
        f = Node(new_data)
        if (self.first==None):
            self.first = f
            self.last = f
        else:
            f.next = self.first
            self.first.prev = f
            self.first = f
            
            
    
    def insertEnd(self, new_data):
        l = Node(new_data)
        if (self.last == None):
            self.last = l
            self.first = l
        else :
            l.prev = self.last
            l.next = None
            self.last.next = l 
            self.last = l
        
    
    def reverse(self):
        if ((self.first == None) or (self.first.next == None)):
            return
        p = self.first.next
        self.first.next = None
        self.first.prev = p 
        self.last = self.first
        q = p.next 
        while (p!=None):
            p.next = self.first
            p.prev = q
            self.first = p 
            p = q 
            if (q!=None):
                q = q.next
        


classDict = { "stack": Stack, "queue": Queue, "linked_list": LinkedList}

class Utils():
    def __init__(self):
        pass

    def parseLine(self, line, delimiter=' '):
        index = line.index(delimiter) if delimiter in line else None
        if index is None:
            return [line, None]
        result = line[0:index]
        remainingLine = line[index + 1:]
        return [result, remainingLine]

    def deleteEndChar(self, line):
        return line.rstrip(line[-1])

    def getAttributePointer(self, object, attribute):
        return getattr(object, attribute)

    def getArgs(self, argsLine):
        return argsLine.split(',') if len(argsLine) != 0 else []

    def runFunction(self, attribute, args):
        result = attribute(*args)
        if result != None:
            print(result)

class MainEmu():
    def __init__(self):
        self.utils = Utils()
        self.items = dict()

    def startProgram(self):
        for line in sys.stdin:
            line = self.utils.deleteEndChar(line)
            action, line = self.utils.parseLine(line)
            actionPointer = self.utils.getAttributePointer(self, action)
            actionPointer(line)

    def make(self, line):
        itemType, line = self.utils.parseLine(line)
        itemName, line = self.utils.parseLine(line)
        self.items[itemName] = classDict[itemType]()

    def call(self, line):
        itemName, line = self.utils.parseLine(line, '.')
        funcName, line = self.utils.parseLine(line, '(')
        argsLine, line = self.utils.parseLine(line, ')')
        args = self.utils.getArgs(argsLine)
        attribute = self.utils.getAttributePointer(self.items[itemName],
                                                   funcName)

        self.utils.runFunction(attribute, args)

if __name__ == "__main__":
    mainEmu = MainEmu()
    mainEmu.startProgram()
