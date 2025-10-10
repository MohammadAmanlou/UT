import main.OrderConstructor.OrderConstructor;
import main.ast.nodes.Program;
import main.grammar.CPYLexer;
import main.grammar.CPYParser;
import main.visitor.TestVisitor;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

import java.io.IOException;

public class SimpleLang {
    public static void main(String[] args) throws IOException {
        CharStream reader = CharStreams.fromFileName(args[0]);
        CPYLexer simpleLangLexer = new CPYLexer(reader);
        CommonTokenStream tokens = new CommonTokenStream(simpleLangLexer);
        CPYParser flParser = new CPYParser(tokens);
        Program program = flParser.program().programRet;
        OrderConstructor orderConstructor = new OrderConstructor(program);
        orderConstructor.compile();
        TestVisitor my_visitor = new TestVisitor();
        my_visitor.visit(program);
        System.out.println("\n");

    }
} 