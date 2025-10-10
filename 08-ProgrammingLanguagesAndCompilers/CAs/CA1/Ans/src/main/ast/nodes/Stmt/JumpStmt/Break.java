package main.ast.nodes.Stmt.JumpStmt;

import main.visitor.IVisitor;

public class Break extends Jump {
    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
