package main.ast.nodes.Operators;

public class Unary extends Operator {
    private String op;

    public Unary(String op) {
        this.op = op;
    }

    @Override
    public void printName()
    {
        System.out.print("~");
    }
}
