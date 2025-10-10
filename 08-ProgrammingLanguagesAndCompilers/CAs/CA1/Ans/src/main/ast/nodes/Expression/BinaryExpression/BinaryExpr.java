package main.ast.nodes.Expression.BinaryExpression;

import main.ast.nodes.Expression.Expression;
import main.ast.nodes.Operators.Operator;
import main.visitor.IVisitor;

public class BinaryExpr extends Expression {
    private Expression leftHand;
    private Expression rightHand;
    private String operator;

    public BinaryExpr() {}


    public BinaryExpr(Expression leftHand, String operator, Expression rightHand) {
        this.leftHand = leftHand;
        this.rightHand = rightHand;
        this.operator = operator;
    }

    public Expression getLeftHand() {
        return leftHand;
    }

    public void setLeftHand(Expression leftHand) {
        this.leftHand = leftHand;
    }

    public Expression getRightHand() {
        return rightHand;
    }

    public void setRightHand(Expression rightHand) {
        this.rightHand = rightHand;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    @Override
    public void printName()
    {
        System.out.print(operator);
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        System.out.print("Line " + Integer.toString(this.getLine()) + ": " );
        System.out.print("Expr ");
        System.out.print(operator);
        System.out.println();
        return visitor.visit(this);
    }
}
