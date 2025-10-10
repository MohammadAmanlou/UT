package main.ast.nodes;

import main.visitor.IVisitor;

public class DigitSeq extends CastExpression{
    private String digitSequenceStr;

    public String getDigitSequenceStr() {
        return digitSequenceStr;
    }

    public void setDigitSequenceStr(String digitSequenceStr) {
        this.digitSequenceStr = digitSequenceStr;
    }

    public DigitSeq(String digitSequenceStr) {
        this.digitSequenceStr = digitSequenceStr;
    }

    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
