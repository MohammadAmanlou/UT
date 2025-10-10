package main.ast.nodes;

import main.visitor.IVisitor;

import java.util.ArrayList;

public class TransUnit extends Node {
    private final ArrayList<ExtDec> externalDeclarations = new ArrayList<>();

    public void addExternalDeclaration(ExtDec e)
    {
        this.externalDeclarations.add(e);
    }
    public ArrayList<ExtDec> getExternalDeclarations()
    {
        return this.externalDeclarations;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }

}
