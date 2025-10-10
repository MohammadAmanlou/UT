package main.ast.nodes;

import main.visitor.IVisitor;

public class DirectAbstDec2 extends DirectAbstDec {
    private AbstractDeclarator abstractDeclarator;

    public AbstractDeclarator getAbstractDeclarator() {
        return abstractDeclarator;
    }

    @Override
    public void setAbstractDeclarator(AbstractDeclarator abstractDeclarator) {
        this.abstractDeclarator = abstractDeclarator;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
