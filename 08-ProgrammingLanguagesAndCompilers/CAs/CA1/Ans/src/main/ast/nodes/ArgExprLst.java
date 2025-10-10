package main.ast.nodes;

import main.ast.nodes.Expression.Expression;
import main.visitor.IVisitor;

import java.util.ArrayList;

public class ArgExprLst extends Node{
    private final ArrayList<Expression> expressions = new ArrayList<>();

    public void addExpression(Expression e)
    {
        this.expressions.add(e);
    }
    public ArrayList<Expression> getExpressions()
    {
        return this.expressions;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
