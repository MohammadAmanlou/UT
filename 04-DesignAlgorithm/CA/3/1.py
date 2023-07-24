import math
class Edge:
     
    def __init__(self):
        self.src = 0
        self.dest = 0
        self.weight = 0
 
# a structure to represent a connected, directed and
# weighted graph
class Graph:
     
    def __init__(self):
         
        # V. Number of vertices, E. Number of edges
        self.V = 0
        self.E = 0
 
        # graph is represented as an array of edges.
        self.edge = None
 
# Creates a graph with V vertices and E edges
def createGraph(V, E):
 
    graph = Graph()
    graph.V = V
    graph.E = E
    graph.edge =[Edge() for i in range(graph.E)]
    return graph
 
# The main function that finds shortest distances
# from src to all other vertices using Bellman-
# Ford algorithm.  The function also detects
# negative weight cycle
def isNegCycleBellmanFord(graph, src):
 
    V = graph.V
    E = graph.E
    dist = [0 for i in range(V)]
    dist[src] = 0
 
    # Step 2: Relax all edges |V| - 1 times.
    # A simple shortest path from src to any
    # other vertex can have at-most |V| - 1
    # edges
    for i in range(1, V):
        for j in range(E):
         
            u = graph.edge[j].src
            v = graph.edge[j].dest
            weight = graph.edge[j].weight
            if ( dist[u] + weight < dist[v]):
                dist[v] = dist[u] + weight
 
    # Step 3: check for negative-weight cycles.
    # The above step guarantees shortest distances
    # if graph doesn't contain negative weight cycle.
    # If we get a shorter path, then there
    # is a cycle.
    for i in range(E):
     
        u = graph.edge[i].src
        v = graph.edge[i].dest
        weight = graph.edge[i].weight
        if ( dist[u] + weight < dist[v]):
            return True
 
    return False


if __name__=='__main__':
    n= int(input())
    m = int(input())
    graph = createGraph(n, m)
    for i in range(m):
        u, v, w = map(float, input().split())
        graph.edge[i].src = int(u) 
        graph.edge[i].dest = int(v)
        graph.edge[i].weight = math.log(w)*-1

    
 
    if (isNegCycleBellmanFord(graph, 0)):
        print("YES")
    else:
        print("NO")