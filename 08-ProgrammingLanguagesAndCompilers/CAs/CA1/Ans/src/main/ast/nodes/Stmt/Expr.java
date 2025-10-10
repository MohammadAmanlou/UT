package main.ast.nodes.Stmt;

import main.ast.nodes.Expression.Expression;
import main.visitor.IVisitor;

public class Expr extends Statement {
    private Expression expression;

    public Expression getExpression() {
        return expression;
    }

    public void setExpression(Expression expression) {
        this.expression = expression;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
