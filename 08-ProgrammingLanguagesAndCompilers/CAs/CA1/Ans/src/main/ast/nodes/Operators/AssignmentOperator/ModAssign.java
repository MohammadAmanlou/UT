package main.ast.nodes.Operators.AssignmentOperator;

import main.visitor.IVisitor;

public class ModAssign extends AssignOp {
    @Override
    public void printName()
    {
        System.out.print("%=");
    }
    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
