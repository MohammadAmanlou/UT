import unittest
import sys
import functools

def for_all_methods(decorator):
    def decorate(cls):
        for attr in cls.__dict__:
            if attr == 'Node':
                setattr(cls, attr, getattr(cls, attr))
            elif callable(getattr(cls, attr)) :
                setattr(cls, attr, decorator(getattr(cls, attr)))
        return cls
    return decorate

@for_all_methods(staticmethod)
class Utils():
    def parse_line(line, delimiter=' '):
        index = line.index(delimiter) if delimiter in line else None
        if index is None:
            return [line, None]
        result = line[0:index]
        remainingLine = line[index + 1:]
        return [result, remainingLine]

    def delete_end_char(line):
        return line.rstrip(line[-1])

    def get_attribute_pointer(object, attribute):
        return getattr(object, attribute)

    def get_args(argsLine):
        return argsLine.split(',') if len(argsLine) != 0 else []

    def run_function(attribute, args):
        result = attribute(*args)
        if result != None:
            print(result)
      
    def covert_args_to_int(args):
        newArgsList = list(args[1:])
        for i in range(1, len(args)):
            if isinstance(args[i], str) and (args[i].isnumeric() or args[i][0] == '-'):
                newArgsList[i - 1] = int(args[i])
        return tuple([args[0]] + newArgsList)
    
    def delete_quotation(args):
        newArgsList = list(args)
        for i in range(1,len(args)):
            if isinstance(newArgsList[i], str):
                newArgsList[i] = newArgsList[i].replace('\'', '')
        return tuple(newArgsList)

def fix_str_arg(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        if(len(args) > 1):
            args = Utils.delete_quotation(args)
            args = Utils.covert_args_to_int(args)
        return func(*args, **kwargs)
    return wrapper

def print_raised_exception(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        try:
            val = func(*args, **kwargs)
            if val != None:
                return val
        except Exception as e:
            print(str(e))
    return wrapper

class MainEmu():
    def __init__(self):
        self.items = dict()

    def start_program(self):
        for line in sys.stdin:
            line = Utils.delete_end_char(line)
            action, line = Utils.parse_line(line)
            actionPointer = Utils.get_attribute_pointer(self, action)
            actionPointer(line)

    def make(self, line):
        itemType, line = Utils.parse_line(line)
        itemName, line = Utils.parse_line(line)
        self.items[itemName] = classDict[itemType]()

    def call(self, line):
        itemName, line = Utils.parse_line(line, '.')
        funcName, line = Utils.parse_line(line, '(')
        argsLine, line = Utils.parse_line(line, ')')
        args = Utils.get_args(argsLine)
        attribute = Utils.get_attribute_pointer(self.items[itemName],
                                                   funcName)

        Utils.run_function(attribute, args)

@for_all_methods(fix_str_arg)
@for_all_methods(print_raised_exception)
class MinHeap:
    def __init__(self):
        self.NOE = 0
        self.elements = []
    
    class Node:
        pass
        
    def bubble_up(self, index):
        if (type(index) != int):
            raise Exception("invalid index")
        index = index + 1
        if (index <= 0 or index > self.NOE):
            raise Exception("out of range index")
        if (index == 1):
            return 
        elif (self.elements[index-1] < self.elements[int(index/2) - 1]):
            self.elements[index-1]  , self.elements[int(index/2) - 1] = self.elements[int(index/2) - 1],self.elements[index-1]
            self.bubble_up(int(index/2)-1)
            
    def bubble_down(self, index):
        if (type(index) != int):
            raise Exception("invalid index")
        index = index + 1
        if (index <= 0 or index > self.NOE):
            raise Exception("out of range index")
        largest = index
        if ((2*index <= self.NOE)and(self.elements[largest - 1] > self.elements[2*index-1])):
            largest = 2*index
        if ((2*index+1 <= self.NOE)and(self.elements[largest - 1] > self.elements[2*index])):
            largest = 2*index+1
        if (index != largest):
            self.elements[index-1] , self.elements[largest-1] = self.elements[largest-1] , self.elements[index-1]
            self.bubble_down(largest - 1)
    
    def heap_push(self, value):
        self.NOE += 1
        self.elements.append(value)
        self.bubble_up(self.NOE - 1)
        
    def heap_pop(self):
        if (self.NOE == 0):
            raise Exception("empty")
        if(self.NOE == 1):
            max_elem = self.elements[0]
            self.elements.pop(-1)
            self.NOE -= 1
            return max_elem
        max_elem = self.elements[0]
        self.elements[0] = self.elements[self.NOE - 1]
        self.elements.pop(-1)
        self.NOE -= 1
        self.bubble_down(0)
        return max_elem
    
    def find_min_child(self, index):
        if (type(index) != int):
            raise Exception("invalid index")
        if (index >= self.NOE or index < 0):
            raise Exception("out of range index")
        if (self.NOE == 0):
            raise Exception("empty")
        return(self.elements.index(min(self.elements[index+1:])))
            
    def heapify(self, *args):
        self.elements = list(args)
        self.elements.sort(reverse = False)
        self.NOE=len(self.elements)

class HuffmanTree:
    def __init__(self):
        self.letters = []
        self.probabs = []
        self.active_nodes = []
        self.lif = []

    @fix_str_arg    
    def set_letters(self,*args):
        for i in args : 
            self.letters.append(i)

    @fix_str_arg    
    def set_repetitions(self,*args):
        for i in args : 
            self.probabs.append(i)

    class Node:
        def __init__(self,probab , symbol):
            self.prob = probab
            self.symb = symbol
            self.right = None
            self.left = None
            self.parent = None

    def build_huffman_tree(self):
        active_prob = self.probabs
        for p , s in zip(self.probabs , self.letters):
            node = self.Node(p , s)
            self.lif.append(node)
            self.active_nodes.append(node)
        
        while (len(active_prob)> 1 ):
            min1 = sorted(active_prob)[0]
            min2 = sorted(active_prob)[1]
            new_node = self.Node(min1+min2 , "")
            self.active_nodes.append(new_node)
            active_prob.append(min1+min2)
            cpy_active_nodes = self.active_nodes.copy()
            do1 = False
            do2 = False
            for n in self.active_nodes:
                if (n.prob == min1 and do1==False):
                    cpy_active_nodes.remove(n)
                    new_node.left = n
                    n.parent = new_node
                    active_prob.remove(min1)
                    do1=True
                elif (n.prob == min2 and do2==False):
                    cpy_active_nodes.remove(n)
                    new_node.right = n
                    n.parent = new_node
                    active_prob.remove(min2)
                    do2=True
            self.active_nodes = cpy_active_nodes
                    

    def get_huffman_code_cost(self):
        cost = 0 
        for n in self.lif : 
            p = 0
            cur = n
            while (cur.parent != None):
                p += 1
                cur = cur.parent
            cost += p * n.prob
        return cost

    @fix_str_arg
    def text_encoding(self, text):
        self.letters = list(set(text))
        for i in self.letters:
            self.probabs.append(text.count(i))
        self.build_huffman_tree()
        
@for_all_methods(fix_str_arg)
@for_all_methods(print_raised_exception)
class RedBlackTree(): 
    def __init__(self):
        self.nil = self.Node(0)
        self.root = self.nil   
    class Node:
        def __init__(self, val):
            self.red = False
            self.parent = None
            self.val = val
            self.left = None
            self.right = None
            

    def fix_insert(self, node):
        while (node != self.root and node.parent.red ) :
            if (node.parent == node.parent.parent.right):
                amoo = node.parent.parent.left  
                if (amoo.red):
                    amoo.red = False
                    node.parent.red = False
                    node.parent.parent.red = True
                    node = node.parent.parent
                else:
                    if (node == node.parent.left):
                        node = node.parent
                        self.right_rotate(node)
                    node.parent.red = False
                    node.parent.parent.red = True
                    self.left_rotate(node.parent.parent)
            else:
                amoo = node.parent.parent.right  

                if (amoo.red):
                    amoo.red = False
                    node.parent.red = False
                    node.parent.parent.red = True
                    node = node.parent.parent
                else:
                    if (node == node.parent.right):
                        node = node.parent
                        self.left_rotate(node)
                    node.parent.red = False
                    node.parent.parent.red = True
                    self.right_rotate(node.parent.parent)
        self.root.red = False
        
    def find_node_color(self, value):
        current = self.root
        parent = None
        while (current != self.nil):
            parent = current
            if value < current.val:
                current = current.left
            elif value > current.val:
                current = current.right
            else:
                break
        if (current.red):
            return "RED"
        else:
            return "BLACK"

    def right_rotate(self, node):
        y = node.left
        node.left = y.right
        if (y.right != self.nil):
            y.right.parent = node

        y.parent = node.parent
        if (node.parent == None):
            self.root = y
        elif (node == node.parent.right):
            node.parent.right = y
        else:
            node.parent.left = y
        y.right = node
        node.parent = y

    def left_rotate(self, node):
        y = node.right
        node.right = y.left
        if node.left != self.nil:
            y.left.parent = node

        y.parent = node.parent
        if (node.parent == None):
            self.root = y
        elif (node == node.parent.left):
            node.parent.left = y
        else:
            node.parent.right = y
        y.left = node
        node.parent = y
        
    def insert(self, value):
        
        node = self.Node(value)
        node.parent = None
        node.left = self.nil
        node.right = self.nil
        node.red = True  

        parent = None
        current = self.root
        while (current != self.nil):
            parent = current
            if (node.val < current.val):
                current = current.left
            elif (node.val >= current.val):
                current = current.right
            else:
                return
        node.parent = parent
        if (parent == None):
            self.root = node
        elif (node.val < parent.val):
            parent.left = node
        else:
            parent.right = node
        self.fix_insert(node)

classDict = { "min_heap": MinHeap, "red_black_tree": RedBlackTree, "huffman_tree": HuffmanTree}
    
if __name__ == "__main__":
    mainEmu = MainEmu()
    mainEmu.start_program()
