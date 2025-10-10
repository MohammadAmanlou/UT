package main.ast.nodes;

import main.visitor.IVisitor;

import java.util.ArrayList;

public class Designation extends Node {
    private final ArrayList<Designator> designators = new ArrayList<>();

    public void addDesignator(Designator d)
    {
        this.designators.add(d);
    }
    public ArrayList<Designator> getDesignators()
    {
        return this.designators;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
