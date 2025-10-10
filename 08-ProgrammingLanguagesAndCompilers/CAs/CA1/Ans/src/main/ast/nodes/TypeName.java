package main.ast.nodes;

import main.visitor.IVisitor;

public class TypeName extends Node{
    private SpecQualifierLst specQualifierLst;
    private AbstractDeclarator abstractDeclarator;

    public SpecQualifierLst getSpecifierQualifierList() {
        return specQualifierLst;
    }

    public void setSpecifierQualifierList(SpecQualifierLst specQualifierLst) {
        this.specQualifierLst = specQualifierLst;
    }

    public AbstractDeclarator getAbstractDeclarator() {
        return abstractDeclarator;
    }

    public void setAbstractDeclarator(AbstractDeclarator abstractDeclarator) {
        this.abstractDeclarator = abstractDeclarator;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
