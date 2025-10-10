package main.ast.nodes;

import main.ast.nodes.Expression.Expression;
import main.visitor.IVisitor;

public class DirectDec1 extends DirectDec {
    private DirectDec directDeclarator;
    private Expression expression;


    public Expression getExpression() {
        return expression;
    }

    public DirectDec1() {
    }

    @Override
    public void printName()
    {
        this.expression.printName();
    }

    @Override
    public void setExpression(Expression expression) {
        this.expression = expression;
    }

    public DirectDec getDirectDeclarator() {
        return directDeclarator;
    }

    @Override
    public void setDirectDeclarator(DirectDec directDeclarator) {
        this.directDeclarator = directDeclarator;
    }

    public DirectDec1(DirectDec directDeclarator, Expression expression) {
        this.directDeclarator = directDeclarator;
        this.expression = expression;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
