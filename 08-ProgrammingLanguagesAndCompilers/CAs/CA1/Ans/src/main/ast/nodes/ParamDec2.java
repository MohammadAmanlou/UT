package main.ast.nodes;

import main.visitor.IVisitor;

public class ParamDec2 extends ParameterDeclaration{
    private DeclarationSpecs declarationSpecifiers;
    private AbstractDeclarator abstractDeclarator;


    public ParamDec2(DeclarationSpecs declarationSpecifiers) {
        this.declarationSpecifiers = declarationSpecifiers;
    }

    public DeclarationSpecs getDeclarationSpecifiers() {
        return declarationSpecifiers;
    }

    public void setDeclarationSpecifiers(DeclarationSpecs declarationSpecifiers) {
        this.declarationSpecifiers = declarationSpecifiers;
    }

    public ParamDec2() {
    }

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
