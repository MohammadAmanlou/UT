package main.ast.nodes;


class MyPair<U, V> {
    public final U first;
    public final V second;

    public MyPair(U first, V second) {
        this.first = first;
        this.second = second;
    }
}
