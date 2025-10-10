package main.ast.nodes;

import main.visitor.IVisitor;

import java.util.ArrayList;

public class DecLst extends Node {
    private final ArrayList<Declaration> declarations = new ArrayList<>();

    public void addDeclaration(Declaration d)
    {
        this.declarations.add(d);
    }

    public ArrayList<Declaration> getDeclarations()
    {
        return this.declarations;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
