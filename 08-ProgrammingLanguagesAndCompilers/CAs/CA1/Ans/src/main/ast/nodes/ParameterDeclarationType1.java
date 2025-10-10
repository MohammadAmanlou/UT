package main.ast.nodes;

import main.visitor.IVisitor;

public class ParameterDeclarationType1 extends ParameterDeclaration{

    private DeclarationSpecs declarationSpecifiers;
    private Declarator declarator;

    public ParameterDeclarationType1(DeclarationSpecs declarationSpecifiers, Declarator declarator) {
        this.declarationSpecifiers = declarationSpecifiers;
        this.declarator = declarator;
    }

    public DeclarationSpecs getDeclarationSpecifiers() {
        return declarationSpecifiers;
    }

    public void setDeclarationSpecifiers(DeclarationSpecs declarationSpecifiers) {
        this.declarationSpecifiers = declarationSpecifiers;
    }

    public Declarator getDeclarator() {
        return declarator;
    }

    public void setDeclarator(Declarator declarator) {
        this.declarator = declarator;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
