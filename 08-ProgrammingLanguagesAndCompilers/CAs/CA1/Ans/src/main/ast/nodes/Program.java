package main.ast.nodes;

import main.visitor.IVisitor;


public class Program extends Node{
    private TransUnit translationUnit;

    public void setTranslationUnit(TransUnit t)
    {
        this.translationUnit = t;
    }
    public TransUnit getTranslationUnit()
    {
        return this.translationUnit;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }

}
