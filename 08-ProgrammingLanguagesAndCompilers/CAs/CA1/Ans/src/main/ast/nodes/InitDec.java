package main.ast.nodes;

import main.visitor.IVisitor;

public class InitDec extends Node {
    private Initializer initializer;
    private Declarator declarator;

    public void setDeclarator(Declarator declarator) {
        this.declarator = declarator;
    }

    public void setInitializer(Initializer initializer) {
        this.initializer = initializer;
    }



    public Initializer getInitializer() {
        return initializer;
    }

    public Declarator getDeclarator() {
        return declarator;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }

}
