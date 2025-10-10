package main.ast.nodes;

import main.ast.nodes.Expression.Expression;
import main.visitor.IVisitor;

public class ForCond2 extends ForCond {
    private Expression expression;
    private ForExpr forExpression1;
    private ForExpr forExpression2;

    public Expression getExpression() {
        return expression;
    }

    @Override
    public void setExpression(Expression expression) {
        this.expression = expression;
    }

    public ForExpr getForExpression1() {
        return forExpression1;
    }

    @Override
    public void setForExpression1(ForExpr forExpression1) {
        this.forExpression1 = forExpression1;
    }

    public ForExpr getForExpression2() {
        return forExpression2;
    }

    @Override
    public void setForExpression2(ForExpr forExpression2) {
        this.forExpression2 = forExpression2;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
