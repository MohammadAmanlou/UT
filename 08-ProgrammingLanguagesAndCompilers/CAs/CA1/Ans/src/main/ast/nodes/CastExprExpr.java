package main.ast.nodes;

import main.ast.nodes.Expression.Expression;
import main.visitor.IVisitor;

public class CastExprExpr extends Expression {
    private TypeName typeName;
    private CastExpression castExpression;

    public TypeName getTypeName() {
        return typeName;
    }

    public void setTypeName(TypeName typeName) {
        this.typeName = typeName;
    }

    public CastExpression getCastExpression() {
        return castExpression;
    }

    public void setCastExpression(CastExpression castExpression) {
        this.castExpression = castExpression;
    }

    public CastExprExpr(TypeName typeName, CastExpression castExpression) {
        this.typeName = typeName;
        this.castExpression = castExpression;
    }

    @Override
    public void printName()
    {
        System.out.print("cast");
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
