package main.ast.nodes.ConstVal;

import main.visitor.IVisitor;

public class IntConst extends ConstVal{
    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
