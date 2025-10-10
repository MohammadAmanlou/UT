package main.ast.nodes.Operators.UnaryOperator;

import main.visitor.IVisitor;

public class Not extends Unary {

    @Override
    public void printName()
    {
        System.out.print("!");
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
