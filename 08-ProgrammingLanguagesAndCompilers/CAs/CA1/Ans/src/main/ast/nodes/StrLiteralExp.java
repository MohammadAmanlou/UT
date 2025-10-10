package main.ast.nodes;

import main.ast.nodes.Expression.Expression;
import main.visitor.IVisitor;

public class StrLiteralExp extends Expression {
    private String text;

    public StrLiteralExp(String text) {
        this.text = text;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    @Override
    public void printName()
    {
        System.out.print(text);
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
