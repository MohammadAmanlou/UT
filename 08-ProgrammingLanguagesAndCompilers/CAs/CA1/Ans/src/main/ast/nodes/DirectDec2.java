package main.ast.nodes;

import main.visitor.IVisitor;

public class DirectDec2 extends DirectDec {
    private DirectDec directDeclarator;
    private SomeLst someList;


    public DirectDec2(DirectDec directDeclarator, SomeLst someList) {
        this.directDeclarator = directDeclarator;
        this.someList = someList;
    }

    @Override
    public void printName()
    {
        this.directDeclarator.printName();
    }

    public DirectDec getDirectDeclarator() {
        return directDeclarator;
    }

    public void setDirectDeclarator(DirectDec directDeclarator) {
        this.directDeclarator = directDeclarator;
    }

    public SomeLst getSomeList() {
        return someList;
    }

    public DirectDec2() {
    }

    @Override
    public void setSomeList(SomeLst someList) {
        this.someList = someList;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
