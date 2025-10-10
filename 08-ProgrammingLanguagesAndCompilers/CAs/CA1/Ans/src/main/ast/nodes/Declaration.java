package main.ast.nodes;

import main.visitor.IVisitor;

public class Declaration extends BlockItem{
    DeclarationSpecs declarationSpecifiers;
    InitDecLst initDeclarationList;


    public DeclarationSpecs getDss() {
        return declarationSpecifiers;
    }

    public InitDecLst getIdl() {
        return initDeclarationList;
    }

    public void setDss(DeclarationSpecs dss) {
        this.declarationSpecifiers = dss;
    }

    public void setIdl(InitDecLst idl) {
        this.initDeclarationList = idl;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
