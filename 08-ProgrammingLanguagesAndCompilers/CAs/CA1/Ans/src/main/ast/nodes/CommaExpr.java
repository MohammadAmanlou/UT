package main.ast.nodes;

import main.ast.nodes.Expression.Expression;
import main.visitor.IVisitor;

import java.util.ArrayList;

public class CommaExpr extends Expression {
    private final ArrayList<Expression> expressions = new ArrayList<>();

    @Override
    public void printName()
    {
        System.out.print(",");
    }

    @Override
    public void addExpression(Expression e)
    {
        this.expressions.add(e);
    }
    public ArrayList<Expression> getExpressions()
    {
        return this.expressions;
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
