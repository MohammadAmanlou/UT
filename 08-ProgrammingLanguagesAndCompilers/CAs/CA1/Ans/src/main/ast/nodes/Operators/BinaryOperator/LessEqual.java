package main.ast.nodes.Operators.BinaryOperator;

import main.visitor.IVisitor;

public class LessEqual extends Binary {
    @Override
    public void printName()
    {
        System.out.print("<=");
    }
    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
