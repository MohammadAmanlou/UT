package main.ast.nodes;

import main.ast.nodes.Stmt.Compound;
import main.visitor.IVisitor;

public class FuncDef extends ExtDec {
    private DeclarationSpecs dss;
    private Declarator d;
    private DecLst dl;
    private Compound cs;


    public DeclarationSpecs getDss() {
        return dss;
    }

    public Declarator getD() {
        return d;
    }

    public DecLst getDl() {
        return dl;
    }

    public Compound getCompound() {
        return cs;
    }

    public void setDeclarationList(DecLst dl) {
        this.dl = dl;
    }

    public void setCompoundStatement(Compound css) {
        this.cs = css;
    }

    public void setDeclarationSpecifiers(DeclarationSpecs dss_)
    {
        this.dss = dss_;
    }

    public void setDeclarator(Declarator d_)
    {
        this.d = d_;
    }
    @Override
    public <T> T accept(IVisitor<T> visitor) {
        System.out.print("Line " + Integer.toString(this.getLine()) + ": " );
        System.out.print("Stmt function ");
        d.printName();
        System.out.print(" = ");
        cs.printNumOfStatements();
        return visitor.visit(this);
    }
}
