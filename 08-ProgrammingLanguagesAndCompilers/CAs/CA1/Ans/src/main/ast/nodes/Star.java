package main.ast.nodes;

import main.visitor.IVisitor;

public class Star extends Node{
    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
