package main.ast.nodes.Stmt.IterationStmt;

import main.ast.nodes.Expression.Expression;
import main.ast.nodes.Stmt.Compound;
import main.ast.nodes.Stmt.Statement;
import main.visitor.IVisitor;

public class DoWhile extends Iter {
    private Expression expression;
    private Compound statement;

    public Expression getExpression() {
        return expression;
    }

    public void setExpression(Expression expression) {
        this.expression = expression;
    }

    public Compound getStatement() {
        return statement;
    }

    public void setStatement(Statement statement) {
        this.statement = (Compound) statement;
    }

    public DoWhile(Expression expression, Statement statement) {
        this.expression = expression;
        this.statement = (Compound) statement;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
