package main.ast.nodes;

import main.visitor.IVisitor;

public class DirectAbstDec5 extends DirectAbstDec {
    private DirectAbstDec directAbstractDeclarator;
    private ParamLst parameterList;

    public DirectAbstDec getDirectAbstractDeclarator() {
        return directAbstractDeclarator;
    }

    @Override
    public void setDirectAbstractDeclarator(DirectAbstDec directAbstractDeclarator) {
        this.directAbstractDeclarator = directAbstractDeclarator;
    }

    public ParamLst getParameterList() {
        return parameterList;
    }

    public void setParameterList(ParamLst parameterList) {
        this.parameterList = parameterList;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
