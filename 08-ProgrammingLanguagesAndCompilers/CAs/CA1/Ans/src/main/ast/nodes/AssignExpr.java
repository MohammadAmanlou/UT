package main.ast.nodes;

import main.ast.nodes.Expression.Expression;
import main.ast.nodes.Operators.AssignOp;
import main.visitor.IVisitor;

public class AssignExpr extends Expression {
    private AssignOp assignmentOperator;
    private Expression expression1;
    private Expression expression2;


    public AssignExpr(AssignOp assignmentOperator, Expression expression2, Expression expression1) {
        this.assignmentOperator = assignmentOperator;
        this.expression2 = expression2;
        this.expression1 = expression1;
    }

    public AssignOp getAssignmentOperator() {
        return assignmentOperator;
    }

    public void setAssignmentOperator(AssignOp assignmentOperator) {
        this.assignmentOperator = assignmentOperator;
    }

    public Expression getExpression2() {
        return expression2;
    }

    public void setExpression2(Expression expression2) {
        this.expression2 = expression2;
    }

    public Expression getExpression1() {
        return expression1;
    }

    public void setExpression1(Expression expression1) {
        this.expression1 = expression1;
    }
    @Override
    public void printName()
    {
        assignmentOperator.printName();
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
