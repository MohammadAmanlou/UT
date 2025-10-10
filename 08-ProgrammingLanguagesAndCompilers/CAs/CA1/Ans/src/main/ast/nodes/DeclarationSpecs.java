package main.ast.nodes;

import main.visitor.IVisitor;

import java.util.ArrayList;

public class DeclarationSpecs extends Node {
    private final ArrayList<DeclarationSpec> dss = new ArrayList<>();

    public void addDeclarationSpecifier(DeclarationSpec ds)
    {
        this.dss.add(ds);
    }
    public ArrayList<DeclarationSpec> getDeclarationSpecifiers()
    {
        return this.dss;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
