package main.ast.nodes;

import main.visitor.IVisitor;



public class SpecQualifierLst1 extends SpecQualifierLst {
    private DeclarationSpec declarationSpecifier;
    private SpecQualifierLst specQualifierLstOptional;

    public SpecQualifierLst1(DeclarationSpec declarationSpecifier, SpecQualifierLst specQualifierLstOptional) {
        this.declarationSpecifier = declarationSpecifier;
        this.specQualifierLstOptional = specQualifierLstOptional;
    }

    public SpecQualifierLst1() {
    }

    public DeclarationSpec getDeclarationSpecifier() {
        return declarationSpecifier;
    }

    @Override
    public void setDeclarationSpecifier(DeclarationSpec declarationSpecifier) {
        this.declarationSpecifier = declarationSpecifier;
    }

    public SpecQualifierLst getSpecifierQualifierListOptional() {
        return specQualifierLstOptional;
    }

    @Override
    public void setSpecifierQualifierListOptional(SpecQualifierLst specQualifierLstOptional) {
        this.specQualifierLstOptional = specQualifierLstOptional;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
