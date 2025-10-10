package main.ast.nodes;

import main.visitor.IVisitor;

import java.util.ArrayList;

import org.antlr.v4.runtime.misc.Pair;


public class InitLst extends Initializer{
    private final ArrayList<Pair<Designation, Initializer>> initializerlist = new ArrayList<>();

    public void addInitializerList(Pair<Designation, Initializer> p)
    {
        this.initializerlist.add(p);
    }
    public ArrayList<Pair<Designation, Initializer>> getInitializerlist()
    {
        return this.initializerlist;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
