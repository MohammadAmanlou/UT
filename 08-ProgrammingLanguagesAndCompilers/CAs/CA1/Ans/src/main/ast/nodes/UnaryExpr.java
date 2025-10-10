package main.ast.nodes;

import main.ast.nodes.Expression.Expression;
import main.ast.nodes.Operators.Unary;
import main.visitor.IVisitor;

public class UnaryExpr extends Expression {
    private Unary unaryOperator;
    private CastExpression castExpression;

    public UnaryExpr(Unary unaryOperator, CastExpression castExpression) {
        this.unaryOperator = unaryOperator;
        this.castExpression = castExpression;
    }

    public Unary getUnaryOperator() {
        return unaryOperator;
    }

    public void setUnaryOperator(Unary unaryOperator) {
        this.unaryOperator = unaryOperator;
    }

    public CastExpression getCastExpression() {
        return castExpression;
    }

    public void setCastExpression(CastExpression castExpression) {
        this.castExpression = castExpression;
    }

    @Override
    public void printName()
    {
        unaryOperator.printName();
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
