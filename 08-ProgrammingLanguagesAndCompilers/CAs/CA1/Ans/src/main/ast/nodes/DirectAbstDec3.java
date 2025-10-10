package main.ast.nodes;

import main.visitor.IVisitor;

public class DirectAbstDec3 extends DirectAbstDec {
    private ParamLst parameterList;

    public ParamLst getParameterList() {
        return parameterList;
    }

    @Override
    public void setParameterList(ParamLst parameterList) {
        this.parameterList = parameterList;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
