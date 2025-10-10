package main.ast.nodes;

import main.ast.nodes.Expression.Expression;
import main.visitor.IVisitor;

public class DirectAbstDec4 extends DirectAbstDec {
    private DirectAbstDec directAbstractDeclarator;
    private Expression expression;

    public DirectAbstDec4(DirectAbstDec directAbstractDeclarator) {
        this.directAbstractDeclarator = directAbstractDeclarator;
    }

    public DirectAbstDec4() {
    }

    public DirectAbstDec getDirectAbstractDeclarator() {
        return directAbstractDeclarator;
    }

    @Override
    public void setDirectAbstractDeclarator(DirectAbstDec directAbstractDeclarator) {
        this.directAbstractDeclarator = directAbstractDeclarator;
    }

    public Expression getExpression() {
        return expression;
    }

    public void setExpression(Expression expression) {
        this.expression = expression;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
