package main.ast.nodes.Expression;

import main.ast.nodes.ArgExprLst;
import main.ast.nodes.Designator;
import main.ast.nodes.Expression.PreExpression.PreExpr;
import main.visitor.IVisitor;

import java.util.ArrayList;

public class Expression extends Designator {
    private ArrayList<PreExpr> preExpressions = new ArrayList<>();

    public void addPreExpression(PreExpr pe){ this.preExpressions.add(pe);}
    public ArrayList<PreExpr> getPreExpression(){ return this.preExpressions;}
    public void setPreExpressions(ArrayList<PreExpr> preExpressions_) { this.preExpressions = preExpressions_; }
    public void addExpression(Expression e){

    }

    public void setArgumentExpressionList(ArgExprLst argumentExpressionList) {
    }

    public void printName()
    {

    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
