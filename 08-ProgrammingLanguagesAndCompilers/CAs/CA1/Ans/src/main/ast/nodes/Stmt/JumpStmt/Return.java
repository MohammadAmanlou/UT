package main.ast.nodes.Stmt.JumpStmt;

import main.ast.nodes.Expression.Expression;
import main.visitor.IVisitor;

public class Return extends Jump {
    private Expression expression;

    public Expression getExpression() {
        return expression;
    }

    @Override
    public void setExpression(Expression expression) {
        this.expression = expression;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        System.out.print("Line " + Integer.toString(this.getLine()) + ": " );
        System.out.print("Expr ");
        expression.printName();
        System.out.println();
        return visitor.visit(this);
    }
}
