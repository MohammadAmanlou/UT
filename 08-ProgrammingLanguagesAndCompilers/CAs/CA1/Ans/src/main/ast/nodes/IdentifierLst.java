package main.ast.nodes;

import main.visitor.IVisitor;

import java.util.ArrayList;

public class IdentifierLst extends SomeLst {
    private final ArrayList<Identifier> identifiers = new ArrayList<>();

    public void addIdentifier(Identifier id)
    {
        this.identifiers.add(id);
    }
    public ArrayList<Identifier> getIdentifiers()
    {
        return this.identifiers;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
