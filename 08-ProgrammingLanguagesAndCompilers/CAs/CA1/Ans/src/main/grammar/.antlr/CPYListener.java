// Generated from c:/Users/a/Desktop/Mehrad/main/grammar/CPY.g4 by ANTLR 4.13.1

    //    import main.ast.nodes.Expression.UnaryExpression.*;

    import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link CPYParser}.
 */
public interface CPYListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link CPYParser#program}.
	 * @param ctx the parse tree
	 */
	void enterProgram(CPYParser.ProgramContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#program}.
	 * @param ctx the parse tree
	 */
	void exitProgram(CPYParser.ProgramContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#translationUnit}.
	 * @param ctx the parse tree
	 */
	void enterTranslationUnit(CPYParser.TranslationUnitContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#translationUnit}.
	 * @param ctx the parse tree
	 */
	void exitTranslationUnit(CPYParser.TranslationUnitContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#externalDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterExternalDeclaration(CPYParser.ExternalDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#externalDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitExternalDeclaration(CPYParser.ExternalDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#functionDefinition}.
	 * @param ctx the parse tree
	 */
	void enterFunctionDefinition(CPYParser.FunctionDefinitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#functionDefinition}.
	 * @param ctx the parse tree
	 */
	void exitFunctionDefinition(CPYParser.FunctionDefinitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#declarationList}.
	 * @param ctx the parse tree
	 */
	void enterDeclarationList(CPYParser.DeclarationListContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#declarationList}.
	 * @param ctx the parse tree
	 */
	void exitDeclarationList(CPYParser.DeclarationListContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterExpression(CPYParser.ExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitExpression(CPYParser.ExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#argumentExpressionList}.
	 * @param ctx the parse tree
	 */
	void enterArgumentExpressionList(CPYParser.ArgumentExpressionListContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#argumentExpressionList}.
	 * @param ctx the parse tree
	 */
	void exitArgumentExpressionList(CPYParser.ArgumentExpressionListContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#unaryOperator}.
	 * @param ctx the parse tree
	 */
	void enterUnaryOperator(CPYParser.UnaryOperatorContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#unaryOperator}.
	 * @param ctx the parse tree
	 */
	void exitUnaryOperator(CPYParser.UnaryOperatorContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#castExpression}.
	 * @param ctx the parse tree
	 */
	void enterCastExpression(CPYParser.CastExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#castExpression}.
	 * @param ctx the parse tree
	 */
	void exitCastExpression(CPYParser.CastExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#assignmentOperator}.
	 * @param ctx the parse tree
	 */
	void enterAssignmentOperator(CPYParser.AssignmentOperatorContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#assignmentOperator}.
	 * @param ctx the parse tree
	 */
	void exitAssignmentOperator(CPYParser.AssignmentOperatorContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#declaration}.
	 * @param ctx the parse tree
	 */
	void enterDeclaration(CPYParser.DeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#declaration}.
	 * @param ctx the parse tree
	 */
	void exitDeclaration(CPYParser.DeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#declarationSpecifiers}.
	 * @param ctx the parse tree
	 */
	void enterDeclarationSpecifiers(CPYParser.DeclarationSpecifiersContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#declarationSpecifiers}.
	 * @param ctx the parse tree
	 */
	void exitDeclarationSpecifiers(CPYParser.DeclarationSpecifiersContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#declarationSpecifier}.
	 * @param ctx the parse tree
	 */
	void enterDeclarationSpecifier(CPYParser.DeclarationSpecifierContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#declarationSpecifier}.
	 * @param ctx the parse tree
	 */
	void exitDeclarationSpecifier(CPYParser.DeclarationSpecifierContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#initDeclaratorList}.
	 * @param ctx the parse tree
	 */
	void enterInitDeclaratorList(CPYParser.InitDeclaratorListContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#initDeclaratorList}.
	 * @param ctx the parse tree
	 */
	void exitInitDeclaratorList(CPYParser.InitDeclaratorListContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#initDeclarator}.
	 * @param ctx the parse tree
	 */
	void enterInitDeclarator(CPYParser.InitDeclaratorContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#initDeclarator}.
	 * @param ctx the parse tree
	 */
	void exitInitDeclarator(CPYParser.InitDeclaratorContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#typeSpecifier}.
	 * @param ctx the parse tree
	 */
	void enterTypeSpecifier(CPYParser.TypeSpecifierContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#typeSpecifier}.
	 * @param ctx the parse tree
	 */
	void exitTypeSpecifier(CPYParser.TypeSpecifierContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#specifierQualifierList}.
	 * @param ctx the parse tree
	 */
	void enterSpecifierQualifierList(CPYParser.SpecifierQualifierListContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#specifierQualifierList}.
	 * @param ctx the parse tree
	 */
	void exitSpecifierQualifierList(CPYParser.SpecifierQualifierListContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#declarator}.
	 * @param ctx the parse tree
	 */
	void enterDeclarator(CPYParser.DeclaratorContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#declarator}.
	 * @param ctx the parse tree
	 */
	void exitDeclarator(CPYParser.DeclaratorContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#directDeclarator}.
	 * @param ctx the parse tree
	 */
	void enterDirectDeclarator(CPYParser.DirectDeclaratorContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#directDeclarator}.
	 * @param ctx the parse tree
	 */
	void exitDirectDeclarator(CPYParser.DirectDeclaratorContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#pointer}.
	 * @param ctx the parse tree
	 */
	void enterPointer(CPYParser.PointerContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#pointer}.
	 * @param ctx the parse tree
	 */
	void exitPointer(CPYParser.PointerContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#parameterList}.
	 * @param ctx the parse tree
	 */
	void enterParameterList(CPYParser.ParameterListContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#parameterList}.
	 * @param ctx the parse tree
	 */
	void exitParameterList(CPYParser.ParameterListContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#parameterDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterParameterDeclaration(CPYParser.ParameterDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#parameterDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitParameterDeclaration(CPYParser.ParameterDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#identifierList}.
	 * @param ctx the parse tree
	 */
	void enterIdentifierList(CPYParser.IdentifierListContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#identifierList}.
	 * @param ctx the parse tree
	 */
	void exitIdentifierList(CPYParser.IdentifierListContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#typeName}.
	 * @param ctx the parse tree
	 */
	void enterTypeName(CPYParser.TypeNameContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#typeName}.
	 * @param ctx the parse tree
	 */
	void exitTypeName(CPYParser.TypeNameContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#abstractDeclarator}.
	 * @param ctx the parse tree
	 */
	void enterAbstractDeclarator(CPYParser.AbstractDeclaratorContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#abstractDeclarator}.
	 * @param ctx the parse tree
	 */
	void exitAbstractDeclarator(CPYParser.AbstractDeclaratorContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#directAbstractDeclarator}.
	 * @param ctx the parse tree
	 */
	void enterDirectAbstractDeclarator(CPYParser.DirectAbstractDeclaratorContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#directAbstractDeclarator}.
	 * @param ctx the parse tree
	 */
	void exitDirectAbstractDeclarator(CPYParser.DirectAbstractDeclaratorContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#initializer}.
	 * @param ctx the parse tree
	 */
	void enterInitializer(CPYParser.InitializerContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#initializer}.
	 * @param ctx the parse tree
	 */
	void exitInitializer(CPYParser.InitializerContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#initializerList}.
	 * @param ctx the parse tree
	 */
	void enterInitializerList(CPYParser.InitializerListContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#initializerList}.
	 * @param ctx the parse tree
	 */
	void exitInitializerList(CPYParser.InitializerListContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#designation}.
	 * @param ctx the parse tree
	 */
	void enterDesignation(CPYParser.DesignationContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#designation}.
	 * @param ctx the parse tree
	 */
	void exitDesignation(CPYParser.DesignationContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#designator}.
	 * @param ctx the parse tree
	 */
	void enterDesignator(CPYParser.DesignatorContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#designator}.
	 * @param ctx the parse tree
	 */
	void exitDesignator(CPYParser.DesignatorContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterStatement(CPYParser.StatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitStatement(CPYParser.StatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#compoundStatement}.
	 * @param ctx the parse tree
	 */
	void enterCompoundStatement(CPYParser.CompoundStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#compoundStatement}.
	 * @param ctx the parse tree
	 */
	void exitCompoundStatement(CPYParser.CompoundStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#blockItem}.
	 * @param ctx the parse tree
	 */
	void enterBlockItem(CPYParser.BlockItemContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#blockItem}.
	 * @param ctx the parse tree
	 */
	void exitBlockItem(CPYParser.BlockItemContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#expressionStatement}.
	 * @param ctx the parse tree
	 */
	void enterExpressionStatement(CPYParser.ExpressionStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#expressionStatement}.
	 * @param ctx the parse tree
	 */
	void exitExpressionStatement(CPYParser.ExpressionStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#selectionStatement}.
	 * @param ctx the parse tree
	 */
	void enterSelectionStatement(CPYParser.SelectionStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#selectionStatement}.
	 * @param ctx the parse tree
	 */
	void exitSelectionStatement(CPYParser.SelectionStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#iterationStatement}.
	 * @param ctx the parse tree
	 */
	void enterIterationStatement(CPYParser.IterationStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#iterationStatement}.
	 * @param ctx the parse tree
	 */
	void exitIterationStatement(CPYParser.IterationStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#forCondition}.
	 * @param ctx the parse tree
	 */
	void enterForCondition(CPYParser.ForConditionContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#forCondition}.
	 * @param ctx the parse tree
	 */
	void exitForCondition(CPYParser.ForConditionContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#forDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterForDeclaration(CPYParser.ForDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#forDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitForDeclaration(CPYParser.ForDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#forExpression}.
	 * @param ctx the parse tree
	 */
	void enterForExpression(CPYParser.ForExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#forExpression}.
	 * @param ctx the parse tree
	 */
	void exitForExpression(CPYParser.ForExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link CPYParser#jumpStatement}.
	 * @param ctx the parse tree
	 */
	void enterJumpStatement(CPYParser.JumpStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link CPYParser#jumpStatement}.
	 * @param ctx the parse tree
	 */
	void exitJumpStatement(CPYParser.JumpStatementContext ctx);
}