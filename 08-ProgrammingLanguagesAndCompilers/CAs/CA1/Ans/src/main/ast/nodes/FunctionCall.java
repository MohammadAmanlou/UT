package main.ast.nodes;

import main.ast.nodes.Expression.Expression;
import main.visitor.IVisitor;

public class FunctionCall extends Expression {

    private Expression expression;
    private ArgExprLst argumentExpressionList;

    public FunctionCall(Expression expression, ArgExprLst argumentExpressionList) {
        this.expression = expression;
        this.argumentExpressionList = argumentExpressionList;
    }

    public FunctionCall(Expression expression) {
        this.expression = expression;
    }

    public Expression getExpression() {
        return expression;
    }


    public void setExpression(Expression expression) {
        this.expression = expression;
    }

    public ArgExprLst getArgumentExpressionList() {
        return argumentExpressionList;
    }

    @Override
    public void setArgumentExpressionList(ArgExprLst argumentExpressionList) {
        this.argumentExpressionList = argumentExpressionList;
    }

    @Override
    public void printName()
    {
        expression.printName();
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
