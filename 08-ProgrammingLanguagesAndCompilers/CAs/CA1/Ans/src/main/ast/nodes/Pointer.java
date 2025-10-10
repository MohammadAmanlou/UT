package main.ast.nodes;

import main.visitor.IVisitor;
import org.antlr.v4.runtime.misc.Pair;

import java.util.ArrayList;


public class Pointer extends Node{
    private final ArrayList<Pair<Star, ArrayList<Const>>> point = new ArrayList<>();

    public void addPoint(Pair<Star, ArrayList<Const>> p)
    {
        this.point.add(p);
    }
    public ArrayList<Pair<Star, ArrayList<Const>>> getPoint()
    {
        return this.point;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
