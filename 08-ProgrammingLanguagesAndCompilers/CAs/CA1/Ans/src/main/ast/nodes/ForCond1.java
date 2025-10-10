package main.ast.nodes;

import main.visitor.IVisitor;

public class ForCond1 extends ForCond {
    private ForDec forDeclaration;
    private ForExpr forExpression1;
    private ForExpr forExpression2;

    public ForDec getForDeclaration() {
        return forDeclaration;
    }

    @Override
    public void setForDeclaration(ForDec forDeclaration) {
        this.forDeclaration = forDeclaration;
    }

    public ForExpr getForExpression2() {
        return forExpression2;
    }

    @Override
    public void setForExpression2(ForExpr forExpression2) {
        this.forExpression2 = forExpression2;
    }

    public ForExpr getForExpression1() {
        return forExpression1;
    }

    @Override
    public void setForExpression1(ForExpr forExpression1) {
        this.forExpression1 = forExpression1;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
