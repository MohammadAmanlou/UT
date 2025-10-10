package main.ast.nodes;

import main.visitor.IVisitor;

public class Declarator extends DirectDec {

    private Pointer pointer;
    private DirectDec directDeclarator;

    public void setPointer(Pointer pointer) {
        this.pointer = pointer;
    }

    public void setDirectDeclarator(DirectDec directDeclarator) {
        this.directDeclarator = directDeclarator;
    }

    public DirectDec getDirectDeclarator() {
        return directDeclarator;
    }

    public Pointer getPointer() {
        return pointer;
    }

    public void printName()
    {
        this.directDeclarator.printName();
    }


    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
