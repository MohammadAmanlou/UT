package main.ast.nodes.Types;

import main.ast.nodes.TypeSpec;
import main.visitor.IVisitor;

public class Signed_ extends TypeSpec {
    @Override
    public <T> T accept(IVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
