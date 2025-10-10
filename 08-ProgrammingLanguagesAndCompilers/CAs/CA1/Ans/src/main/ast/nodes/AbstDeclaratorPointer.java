package main.ast.nodes;

import main.visitor.IVisitor;

public class AbstDeclaratorPointer extends AbstractDeclarator{
    private Pointer pointer;


    public Pointer getPointer() {
        return pointer;
    }

    @Override
    public void setPointer(Pointer pointer) {
        this.pointer = pointer;
    }

    public AbstDeclaratorPointer(Pointer pointer) {
        this.pointer = pointer;
    }


    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
