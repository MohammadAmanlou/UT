package main.ast.nodes;

import main.ast.nodes.Expression.Expression;
import main.visitor.IVisitor;


public class CompoundLiteral extends Expression {
    private InitLst initializerList;
    private TypeName typeName;


    public CompoundLiteral(TypeName typeName, InitLst initializerList) {
        this.initializerList = initializerList;
        this.typeName = typeName;
    }

    public InitLst getInitDeclaratorList() {
        return initializerList;
    }

    public void setInitDeclaratorList(InitLst initializerList) {
        this.initializerList = initializerList;
    }

    public TypeName getTypeName() {
        return typeName;
    }

    public void setTypeName(TypeName typeName) {
        this.typeName = typeName;
    }

    @Override
    public void printName()
    {
        System.out.print("(");
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        System.out.print("Line " + Integer.toString(this.getLine()) + ": " );
        System.out.print("Expr ");
        printName();
        System.out.println();
        return visitor.visit(this);
    }
}
