package main.ast.nodes;

import main.visitor.IVisitor;

public class Identifier extends DirectDec {
    private String name;

    public Identifier(String _name)
    {
        name = _name;
    }
    public void setName(String name)
    {
        this.name = name;
    }
    public String getName()
    {
        return this.name;
    }

    @Override
    public void printName()
    {
        System.out.print(name);
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {

        return visitor.visit(this);
    }


}
