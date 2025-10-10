package main.ast.nodes;

import main.visitor.IVisitor;

import java.util.ArrayList;

public class ParamLst extends SomeLst {
    private final ArrayList<ParameterDeclaration> parameterDeclarations = new ArrayList<>();

    public void addParameterDeclaration(ParameterDeclaration e)
    {
        this.parameterDeclarations.add(e);
    }
    public ArrayList<ParameterDeclaration> getParameterDeclarations()
    {
        return this.parameterDeclarations;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
