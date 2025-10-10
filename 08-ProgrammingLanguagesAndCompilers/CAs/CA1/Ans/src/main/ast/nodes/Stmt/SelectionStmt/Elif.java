package main.ast.nodes.Stmt.SelectionStmt;

import main.ast.nodes.Expression.Expression;
import main.ast.nodes.Stmt.Compound;
import main.visitor.IVisitor;

public class Elif extends Selection {
    private Expression expression;
    private Compound compound;
    private Elif elif;
    private Else anElse;

    public Elif getElif() {
        return elif;
    }

    public void setElif(Elif elif) {
        this.elif = elif;
    }

    public Else getAnElse() {
        return anElse;
    }

    public void setElse(Else anElse) {
        this.anElse = anElse;
    }

    public Compound getCompoundStatement() {
        return compound;
    }

    public void setCompoundStatement(Compound compound) {
        this.compound = compound;
    }

    public Expression getExpression() {
        return expression;
    }

    public void setExpression(Expression expression1) {
        this.expression = expression1;
    }

    public Elif(Expression expression) {
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
        System.out.print("Stmt selection");
        System.out.print(" = ");
        compound.printNumOfStatements();
        return visitor.visit(this);
    }
}
