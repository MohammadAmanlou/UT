package main.ast.nodes;

import main.visitor.IVisitor;

public class AbstractDeclaratorDirect extends AbstractDeclarator{
    private Pointer pointer;
    private DirectAbstDec directAbstractDeclarator;


    public AbstractDeclaratorDirect(Pointer pointer, DirectAbstDec directAbstractDeclarator) {
        this.pointer = pointer;
        this.directAbstractDeclarator = directAbstractDeclarator;
    }

    public AbstractDeclaratorDirect() {
    }

    public Pointer getPointer() {
        return pointer;
    }

    @Override
    public void setPointer(Pointer pointer) {
        this.pointer = pointer;
    }


    public DirectAbstDec getDirectAbstractDeclarator() {
        return directAbstractDeclarator;
    }

    @Override
    public void setDirectAbstractDeclarator(DirectAbstDec directAbstractDeclarator) {
        this.directAbstractDeclarator = directAbstractDeclarator;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
