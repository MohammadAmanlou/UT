package main.ast.nodes;

import main.visitor.IVisitor;

public class TypeDef extends DeclarationSpec {
    @Override
    public <T> T accept(IVisitor<T> visitor) {

        return visitor.visit(this);
    }
}
