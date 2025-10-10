package main.ast.nodes.Stmt.IterationStmt;

import main.ast.nodes.Expression.Expression;
import main.ast.nodes.Stmt.Compound;
import main.visitor.IVisitor;

public class While extends Iter {
    private Expression expression;
    private Compound compound;


    public Compound getCompoundStatement() {
        return compound;
    }

    public void setCompoundStatement(Compound compound) {
        this.compound = compound;
    }

    public Expression getExpression() {
        return expression;
    }

    public void setExpression(Expression expression) {
        this.expression = expression;
    }


    public While(Expression expression, Compound compound) {
        this.compound = compound;
        this.expression = expression;
    }

    public While(Expression expression) {
        this.expression = expression;
        this.compound = new Compound();
    }
    @Override
    public <T> T accept(IVisitor<T> visitor) {
        System.out.print("Line " + Integer.toString(this.getLine()) + ": " );
        System.out.print("Expr ");
        expression.printName();
        System.out.println();
        System.out.print("Line " + Integer.toString(this.getLine()) + ": " );
        System.out.print("Stmt while");
        System.out.print(" = ");
        compound.printNumOfStatements();
        return visitor.visit(this);
    }
}
