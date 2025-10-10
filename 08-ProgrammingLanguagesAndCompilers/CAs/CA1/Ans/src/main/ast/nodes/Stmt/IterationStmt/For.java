package main.ast.nodes.Stmt.IterationStmt;

import main.ast.nodes.ForCond;
import main.ast.nodes.Stmt.Compound;
import main.visitor.IVisitor;

public class For extends Iter {
    private Compound compound;
    private ForCond forCondition;

    public Compound getCompoundStatement() {
        return compound;
    }

    public void setCompoundStatement(Compound compound) {
        this.compound = compound;
    }

    public ForCond getForCondition() {
        return forCondition;
    }

    public void setForCondition(ForCond forCondition) {
        this.forCondition = forCondition;
    }

    public For(ForCond forCondition, Compound statement) {
        this.compound = statement;
        this.forCondition = forCondition;
    }

    public For(ForCond forCondition) {
        this.forCondition = forCondition;
        this.compound = new Compound();
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        System.out.print("Line " + Integer.toString(this.getLine()) + ": " );
        System.out.print("Stmt for");
        System.out.print(" = ");
        compound.printNumOfStatements();
        return visitor.visit(this);
    }
}
