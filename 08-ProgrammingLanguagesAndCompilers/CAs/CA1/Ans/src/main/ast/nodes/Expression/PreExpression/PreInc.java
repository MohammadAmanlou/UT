package main.ast.nodes.Expression.PreExpression;

import main.visitor.IVisitor;

public class PreInc extends PreExpr {
    public PreInc() {

    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
