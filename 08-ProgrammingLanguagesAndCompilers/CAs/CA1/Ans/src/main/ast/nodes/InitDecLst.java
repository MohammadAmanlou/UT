package main.ast.nodes;

import main.visitor.IVisitor;

import java.util.ArrayList;

public class InitDecLst extends Node {
    private final ArrayList<InitDec> initDeclarators = new ArrayList<>();

    public void addInitDeclarator(InitDec id)
    {
        this.initDeclarators.add(id);
    }
    public ArrayList<InitDec> getInitDeclarators()
    {
        return this.initDeclarators;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
