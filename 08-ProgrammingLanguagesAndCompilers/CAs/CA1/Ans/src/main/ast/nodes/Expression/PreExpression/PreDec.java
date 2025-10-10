package main.ast.nodes.Expression.PreExpression;

import main.visitor.IVisitor;

public class PreDec extends PreExpr {
    public PreDec() {

    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
