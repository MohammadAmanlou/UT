package main.ast.nodes.Expression.PostExpression;

import main.ast.nodes.Expression.Expression;
import main.visitor.IVisitor;

public class PostDec extends PostExpr {
    private Expression expression;

    public PostDec(Expression expression) {
        this.expression = expression;
    }

    public Expression getExpression() {
        return expression;
    }

    public void setExpression(Expression expression) {
        this.expression = expression;
    }

    @Override
    public void printName()
    {
        System.out.print("--");
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        System.out.print("Line " + Integer.toString(this.getLine()) + ": " );
        System.out.print("Expr ");
        printName();
        System.out.println();
        return visitor.visit(this);
    }
}
