package main.visitor;

import main.ast.nodes.*;
import main.ast.nodes.Operators.AssignOp;
import main.ast.nodes.Operators.Unary;
import main.ast.nodes.Types.Double_;
import main.ast.nodes.Types.Float_;
import main.ast.nodes.Types.Long_;
import main.ast.nodes.Types.Short_;
import main.ast.nodes.Types.Void_;
import org.antlr.v4.runtime.misc.Pair;


/*GOALs:
 *   1. print out scope changes each time a new scope starts
 *   2. print the identifier if it is initialized
 *   3. print the identifier if it is used
 *   4. print out the name of the function when it is defined
 *   5. print out the name of the function when it is used
 *
 * */


import main.ast.nodes.ConstVal.*;
import main.ast.nodes.Stmt.*;
import main.ast.nodes.Stmt.JumpStmt.*;
import main.ast.nodes.Stmt.IterationStmt.*;
import main.ast.nodes.Expression.*;
import main.ast.nodes.Expression.BinaryExpression.*;
import main.ast.nodes.Types.*;
import main.ast.nodes.Expression.PostExpression.*;
import main.ast.nodes.Expression.PreExpression.*;
import main.ast.nodes.Stmt.SelectionStmt.*;

public abstract class Visitor<T> implements IVisitor<T> {
        @Override public T visit(AbstractDeclaratorDirect node) { return null; }
        @Override public T visit(AbstDeclaratorPointer node) { return null; }
        @Override public T visit(ArgExprLst node) { return null; }
        @Override public T visit(ArrAccess node) { return null; }
        @Override public T visit(AssignExpr node) { return null; }
        @Override public T visit(BinaryExpr node) { return null; }
        @Override public T visit(Bool_ node) { return null; }
        @Override public T visit(Break node) { return null; }
        @Override public T visit(CastExpressionAgain node) { return null; }
        @Override public T visit(CastExprAlone node) { return null; }
        @Override public T visit(CastExprExpr node) { return null; }
        @Override public T visit(CharConst node) { return null; }
        @Override public T visit(Char_ node) { return null; }
        @Override public T visit(CommaExpr node) { return null; }
        @Override public T visit(CommonExpr node) { return null; }
        @Override public T visit(CompoundLiteral node) { return null; }
        @Override public T visit(Compound node) { return null; }
        @Override public T visit(CondExpr node) { return null; }
        @Override public T visit(Const node) { return null; }
        @Override public T visit(ConstVal node) { return null; }
        @Override public T visit(Continue node) { return null; }
        @Override public T visit(Declaration node) { return null; }
        @Override public T visit(DecLst node) { return null; }
        @Override public T visit(DeclarationSpecs node) { return null; }
        @Override public T visit(Declarator node) { return null; }
        @Override public T visit(Designation node) { return null; }
        @Override public T visit(DigitSeq node) { return null; }
        @Override public T visit(DirectAbstDec1 node) { return null; }
        @Override public T visit(DirectAbstDec2 node) { return null; }
        @Override public T visit(DirectAbstDec3 node) { return null; }
        @Override public T visit(DirectAbstDec4 node) { return null; }
        @Override public T visit(DirectAbstDec5 node) { return null; }
        @Override public T visit(DirectDec1 node) { return null; }
        @Override public T visit(DirectDec2 node) { return null; }
        @Override public T visit(DoWhile node) { return null; }
        @Override public T visit(Double_ node) { return null; }
        @Override public T visit(Elif node) { return null; }
        @Override public T visit(Else node) { return null; }
        @Override public T visit(Expr node) { return null; }
        @Override public T visit(FloatConst node) { return null; }
        @Override public T visit(Float_ node) { return null; }
        @Override public T visit(For node) { return null; }
        @Override public T visit(ForCond1 node) { return null; }
        @Override public T visit(ForCond2 node) { return null; }
        @Override public T visit(ForDec node) { return null; }
        @Override public T visit(ForExpr node) { return null; }
        @Override public T visit(FunctionCall node) { return null; }
        @Override public T visit(FuncDef node) { return null; }
        @Override public T visit(IF node) { return null; }
        @Override public T visit(Identifier node) { return null; }
        @Override public T visit(IdentifierLst node) { return null; }
        @Override public T visit(InitDec node) { return null; }
        @Override public T visit(InitDecLst node) { return null; }
        @Override public T visit(InitLst node) { return null; }
        @Override public T visit(IntConst node) { return null; }
        @Override public T visit(Int_ node) { return null; }
        @Override public T visit(Long_ node) { return null; }
        @Override public T visit(ParameterDeclarationType1 node) { return null; }
        @Override public T visit(ParamDec2 node) { return null; }
        @Override public T visit(ParamLst node) { return null; }
        @Override public T visit(Pointer node) { return null; }
        @Override public T visit(PostDec node) { return null; }
        @Override public T visit(PostInc node) { return null; }
        @Override public T visit(PreDec node) { return null; }
        @Override public T visit(PreInc node) { return null; }
        @Override public T visit(PreSizeOf node) { return null; }
        @Override public T visit(Program node) { return null; }
        @Override public T visit(Return node) { return null; }
        @Override public T visit(Short_ node) { return null; }
        @Override public T visit(Signed_ node) { return null; }
        @Override public T visit(SizeofType node) { return null; }
        @Override public T visit(SpecQualifierLst1 node) { return null; }
        @Override public T visit(SpecQualifierLst2 node) { return null; }
        @Override public T visit(Star node) { return null; }
        @Override public T visit(StrLiteralExp node) { return null; }
        @Override public T visit(TransUnit node) { return null; }
        @Override public T visit(TypeDef node) { return null; }
        @Override public T visit(TypeName node) { return null; }
        @Override public T visit(Unsigned_ node) { return null; }
        @Override public T visit(UnaryExpr node) { return null; }
        @Override public T visit(Void_ node) { return null; }
        @Override public T visit(While node) { return null; }
        @Override public T visit(AbstractDeclarator node) { return null; }
        @Override public T visit(Expression node) { return null; }
        @Override public T visit(ParanExpr node) { return null; }
        @Override public T visit(IdentifierExpr node) { return null; }
        @Override public T visit(Unary node) {return  null;}
        @Override public T visit(AssignOp node) {return  null;}
    }
