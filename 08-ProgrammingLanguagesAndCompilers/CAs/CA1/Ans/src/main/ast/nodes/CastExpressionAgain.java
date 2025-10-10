package main.ast.nodes;

import main.visitor.IVisitor;

public class CastExpressionAgain extends CastExpression{
    private TypeName typeName;
    private CastExpression castExpression;

    public CastExpressionAgain(TypeName typeName, CastExpression castExpression) {
        this.typeName = typeName;
        this.castExpression = castExpression;
    }

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

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
