package main.ast.nodes.Stmt.SelectionStmt;

import main.ast.nodes.Stmt.Compound;
import main.visitor.IVisitor;

public class Else extends Selection {
    private Compound compound;

    public Compound getCompoundStatement() {
        return compound;
    }

    public void setCompoundStatement(Compound compound) {
        this.compound = compound;
    }

    public Else() {
        this.compound = new Compound();
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        System.out.print("Line " + Integer.toString(this.getLine()) + ": " );
        System.out.print("Stmt selection");
        System.out.print(" = ");
        compound.printNumOfStatements();
        return visitor.visit(this);
    }
}
