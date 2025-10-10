package main.ast.nodes;

import main.visitor.IVisitor;

public class ForDec extends Node{
    private DeclarationSpecs declarationSpecifiers;
    private InitDecLst initDeclaratorList;

    public InitDecLst getInitDeclaratorList() {
        return initDeclaratorList;
    }

    public void setInitDeclaratorList(InitDecLst initDeclaratorList) {
        this.initDeclaratorList = initDeclaratorList;
    }

    public DeclarationSpecs getDeclarationSpecifiers() {
        return declarationSpecifiers;
    }

    public void setDeclarationSpecifiers(DeclarationSpecs declarationSpecifiers) {
        this.declarationSpecifiers = declarationSpecifiers;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
