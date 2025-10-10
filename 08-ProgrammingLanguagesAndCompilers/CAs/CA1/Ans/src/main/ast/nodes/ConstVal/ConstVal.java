package main.ast.nodes.ConstVal;

import main.ast.nodes.Expression.Expression;
import main.visitor.IVisitor;

public class ConstVal extends Expression {
    private String type;

    public ConstVal(String t) {
        this.type = t;
    }

    public ConstVal() {

    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public void printName()
    {
        System.out.print(type);
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        System.out.print("Line " + Integer.toString(this.getLine()) + ": " );
        System.out.print("Expr ");
        printName();
        System.out.println();
        return visitor.visit(this);
    }
}
