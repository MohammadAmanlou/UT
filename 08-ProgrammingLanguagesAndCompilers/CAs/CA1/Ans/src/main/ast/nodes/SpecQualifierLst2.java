package main.ast.nodes;

import main.visitor.IVisitor;

public class SpecQualifierLst2 extends SpecQualifierLst {


    private Const aConst;

    public SpecQualifierLst2(Const aConst) {
        this.aConst = aConst;
    }

    public Const getaConst() {
        return aConst;
    }

    public void setaConst(Const aConst) {
        this.aConst = aConst;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
