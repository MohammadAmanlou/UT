package main.ast.nodes.Operators;

public class AssignOp extends Operator {
    private String op;

    public AssignOp(String op) {
        this.op = op;
    }

    @Override
    public void printName()
    {
        System.out.print(op);
    }
}
