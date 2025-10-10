package main.ast.nodes.Expression.PreExpression;

import main.visitor.IVisitor;

public class PreSizeOf extends PreExpr {

    public PreSizeOf() {

    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }

}
