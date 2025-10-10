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


import java.util.ArrayList;


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


public class TestVisitor implements IVisitor<java.lang.Void> {

    @Override
    public Void visit(Unary node)
    {
        return null;
    }

    @Override
    public Void visit(AssignOp node)
    {
        return null;
    }

    @Override
    public java.lang.Void visit(AbstractDeclarator node)
    {
       return null;
    }

    @Override
    public java.lang.Void visit(AbstractDeclaratorDirect node) {
        if (node.getPointer() != null) {
            node.getPointer().accept(this);
        }
        if (node.getDirectAbstractDeclarator() != null) {
            node.getDirectAbstractDeclarator().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(AbstDeclaratorPointer node) {
        if (node.getPointer() != null) {
            node.getPointer().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(ArgExprLst node) {
        return null;
    }

    @Override
    public java.lang.Void visit(ArrAccess node) {
        return null;
    }

    @Override
    public java.lang.Void visit(ParanExpr node)
    {
        return null;
    }

    @Override
    public java.lang.Void visit(IdentifierExpr node)
    {
        return null;
    }

    @Override
    public java.lang.Void visit(AssignExpr node) {
        if (node.getAssignmentOperator() != null) {
            node.getAssignmentOperator().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(CastExpressionAgain node) {
        if (node.getTypeName() != null) {
            node.getTypeName().accept(this);
        }
        if (node.getCastExpression() != null) {
            node.getCastExpression().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(CastExprAlone node) {
        if (node.getExpression() != null) {
            node.getExpression().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(CastExprExpr node) {
        return null;
    }

    @Override
    public java.lang.Void visit(CommaExpr node) {
        return null;
    }

    @Override
    public java.lang.Void visit(CommonExpr node) {
        return null;
    }

    @Override
    public java.lang.Void visit(CompoundLiteral node) {
        if (node.getInitDeclaratorList() != null) {
            node.getInitDeclaratorList().accept(this);
        }
        if (node.getTypeName() != null) {
            node.getTypeName().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(CondExpr node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Const node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Declaration node) {
        if (node.getDss() != null)
        {
            node.getDss().accept(this);
        }
        if (node.getIdl() != null)
        {
            node.getIdl().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(DecLst node) {
        for (Declaration declaration : node.getDeclarations())
        {
            if (declaration != null)
            {
                declaration.accept(this);
            }
        }
        return null;
    }

    @Override
    public java.lang.Void visit(DeclarationSpecs node) {
        for (DeclarationSpec declarationSpecifier : node.getDeclarationSpecifiers())
        {
            if (declarationSpecifier != null)
            {
                declarationSpecifier.accept(this);
            }
        }
        return null;
    }

    @Override
    public java.lang.Void visit(Declarator node) {
        if (node.getPointer() != null) {
            node.getPointer().accept(this);
        }
        if (node.getDirectDeclarator() != null) {
            node.getDirectDeclarator().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(Designation node) {
        for (Designator designator : node.getDesignators())
        {
            if (designator != null)
            {
                designator.accept(this);
            }
        }
        return null;
    }

    @Override
    public java.lang.Void visit(DigitSeq node) {
        return null;
    }

    @Override
    public java.lang.Void visit(DirectAbstDec1 node) {
        if (node.getExpression() != null) {
            node.getExpression().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(DirectAbstDec2 node) {
        if (node.getAbstractDeclarator() != null) {
            node.getAbstractDeclarator().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(DirectAbstDec3 node) {
        if (node.getParameterList() != null) {
            node.getParameterList().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(DirectAbstDec4 node) {
        if (node.getDirectAbstractDeclarator() != null) {
            node.getDirectAbstractDeclarator().accept(this);
        }
        if (node.getExpression() != null) {
            node.getExpression().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(DirectAbstDec5 node) {
        if (node.getDirectAbstractDeclarator() != null) {
            node.getDirectAbstractDeclarator().accept(this);
        }
        if (node.getParameterList() != null) {
            node.getParameterList().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(DirectDec1 node) {
        if (node.getDirectDeclarator() != null) {
            node.getDirectDeclarator().accept(this);
        }
        if (node.getExpression() != null) {
            node.getExpression().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(DirectDec2 node) {
        if (node.getDirectDeclarator() != null) {
            node.getDirectDeclarator().accept(this);
        }
        if (node.getSomeList() != null) {
            node.getSomeList().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(ForCond1 node) {
        if (node.getForDeclaration() != null) {
            node.getForDeclaration().accept(this);
        }
        if (node.getForExpression1() != null) {
            node.getForExpression1().accept(this);
        }
        if (node.getForExpression2() != null) {
            node.getForExpression2().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(ForCond2 node) {
        if (node.getExpression() != null) {
            node.getExpression().accept(this);
        }
        if (node.getForExpression1() != null) {
            node.getForExpression1().accept(this);
        }
        if (node.getForExpression2() != null) {
            node.getForExpression2().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(ForDec node) {
        if (node.getDeclarationSpecifiers() != null) {
            node.getDeclarationSpecifiers().accept(this);
        }
        if (node.getInitDeclaratorList() != null) {
            node.getInitDeclaratorList().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(ForExpr node) {
        for (Expression expression : node.getExpressions())
        {
            if (expression != null)
            {
                expression.accept(this);
            }
        }
        return null;
    }

    @Override
    public java.lang.Void visit(FunctionCall node) {
        return null;
    }

    @Override
    public java.lang.Void visit(FuncDef node) {
        if (node.getDss() != null) {
            node.getDss().accept(this);
        }
        if (node.getD() != null) {
            node.getD().accept(this);
        }
        if (node.getDl() != null) {
            node.getDl().accept(this);
        }
        if (node.getCompound() != null) {
            node.getCompound().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(Identifier node) {
        return null;
    }

    @Override
    public java.lang.Void visit(IdentifierLst node) {
        for (Identifier identifier : node.getIdentifiers())
        {
            if (identifier != null)
            {
                identifier.accept(this);
            }
        }
        return null;
    }

    @Override
    public java.lang.Void visit(InitDec node) {
        if (node.getInitializer() != null) {
            node.getInitializer().accept(this);
        }
        if (node.getDeclarator() != null) {
            node.getDeclarator().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(InitDecLst node) {
        for (InitDec initDeclarator : node.getInitDeclarators())
        {
            if (initDeclarator != null)
            {
                initDeclarator.accept(this);
            }
        }
        return null;
    }

    @Override
    public java.lang.Void visit(InitLst node) {
        for (Pair<Designation, Initializer> pair : node.getInitializerlist())
        {
            if (pair != null)
            {
                if (pair.a != null)
                {
                    pair.a.accept(this);
                }
                if (pair.b != null)
                {
                    pair.b.accept(this);
                }
            }
        }
        return null;
    }

    @Override
    public java.lang.Void visit(ParameterDeclarationType1 node) {
        if (node.getDeclarationSpecifiers() != null) {
            node.getDeclarationSpecifiers().accept(this);
        }
        if (node.getDeclarator() != null) {
            node.getDeclarator().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(ParamDec2 node) {
        if (node.getDeclarationSpecifiers() != null) {
            node.getDeclarationSpecifiers().accept(this);
        }
        if (node.getAbstractDeclarator() != null) {
            node.getAbstractDeclarator().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(ParamLst node) {
        for (ParameterDeclaration parameterDeclaration : node.getParameterDeclarations())
        {
            if (parameterDeclaration != null)
            {
                parameterDeclaration.accept(this);
            }
        }
        return null;
    }

    @Override
    public java.lang.Void visit(Pointer node) {
        for (Pair<Star, ArrayList<Const>> pair : node.getPoint())
        {
            if (pair != null)
            {
                if (pair.a != null)
                {
                    pair.a.accept(this);
                }
                if (pair.b != null)
                {
                    for (Const aconst: pair.b)
                    {
                        aconst.accept(this);
                    }
                }
            }
        }
        return null;
    }

    @Override
    public java.lang.Void visit(Program node) {
        if (node.getTranslationUnit() != null) {
            node.getTranslationUnit().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(SizeofType node) {
        if (node.getTypeName() != null) {
            node.getTypeName().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(SpecQualifierLst1 node) {
        if (node.getDeclarationSpecifier() != null) {
            node.getDeclarationSpecifier().accept(this);
        }
        if (node.getSpecifierQualifierListOptional() != null) {
            node.getSpecifierQualifierListOptional().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(SpecQualifierLst2 node) {
        if (node.getaConst() != null) {
            node.getaConst().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(Star node) {
        return null;
    }

    @Override
    public java.lang.Void visit(StrLiteralExp node) {
        return null;
    }

    @Override
    public java.lang.Void visit(TransUnit node) {
        for (ExtDec externalDeclaration : node.getExternalDeclarations())
        {
            if (externalDeclaration != null)
            {
                externalDeclaration.accept(this);
            }
        }
        return null;
    }

    @Override
    public java.lang.Void visit(TypeDef node) {
        return null;
    }

    @Override
    public java.lang.Void visit(TypeName node) {
        if (node.getSpecifierQualifierList() != null) {
            node.getSpecifierQualifierList().accept(this);
        }
        if (node.getAbstractDeclarator() != null) {
            node.getAbstractDeclarator().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(UnaryExpr node) {
        if (node.getUnaryOperator() != null) {
            node.getUnaryOperator().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(CharConst node) {
        return null;
    }

    @Override
    public java.lang.Void visit(ConstVal node) {
        return null;
    }

    @Override
    public java.lang.Void visit(FloatConst node) {
        return null;
    }

    @Override
    public java.lang.Void visit(IntConst node) {
        return null;
    }

    @Override
    public java.lang.Void visit(BinaryExpr node) {
        return null;
    }

    @Override
    public java.lang.Void visit(PostDec node) {
        return null;
    }

    @Override
    public java.lang.Void visit(PostInc node) {
        return null;
    }

    @Override
    public java.lang.Void visit(PreDec node) {
        return null;
    }

    @Override
    public java.lang.Void visit(PreInc node) {
        return null;
    }

    @Override
    public java.lang.Void visit(PreSizeOf node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Expression node) {
        for (PreExpr preExpression : node.getPreExpression())
        {
            if (preExpression != null)
            {
                preExpression.accept(this);
            }
        }
        return null;
    }
    @Override
    public java.lang.Void visit(Compound node) {
        for (BlockItem blockItem : node.getBlockItems())
        {
            if (blockItem != null)
            {
                blockItem.accept(this);
            }
        }
        return null;
    }

    @Override
    public java.lang.Void visit(Expr node) {
        if (node.getExpression() != null) {
            node.getExpression().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(DoWhile node) {
        if (node.getExpression() != null) {
            node.getExpression().accept(this);
        }
        if (node.getStatement() != null) {
            node.getStatement().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(For node) {
        if (node.getCompoundStatement() != null) {
            node.getCompoundStatement().accept(this);
        }
        if (node.getForCondition() != null) {
            node.getForCondition().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(While node) {
//        node.getExpression().accept(this);
        node.getCompoundStatement().accept(this);
        return null;
    }

    @Override
    public java.lang.Void visit(Break node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Continue node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Return node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Elif node) {
        if (node.getCompoundStatement() != null) {
            node.getCompoundStatement().accept(this);
        }
        if (node.getElif() != null) {
            node.getElif().accept(this);
        }
        if (node.getAnElse() != null) {
            node.getAnElse().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(Else node) {
        if (node.getCompoundStatement() != null) {
            node.getCompoundStatement().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(IF node) {
        if (node.getExpression() != null) {
            System.out.println();
        }
        if (node.getCompoundStatement() != null) {
            node.getCompoundStatement().accept(this);
        }
        if (node.getElif() != null) {
            node.getElif().accept(this);
        }
        if (node.getAnElse() != null) {
            node.getAnElse().accept(this);
        }
        return null;
    }

    @Override
    public java.lang.Void visit(Bool_ node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Char_ node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Double_ node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Float_ node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Int_ node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Long_ node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Short_ node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Signed_ node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Unsigned_ node) {
        return null;
    }

    @Override
    public java.lang.Void visit(Void_ node) {
        return null;
    }

}