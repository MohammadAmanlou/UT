grammar CPY;


@header{
    import main.ast.nodes.*;
    import main.ast.nodes.ConstVal.*;
    import main.ast.nodes.Stmt.*;
    import main.ast.nodes.Stmt.JumpStmt.*;
    import main.ast.nodes.Stmt.IterationStmt.*;
    import main.ast.nodes.Expression.*;
    import main.ast.nodes.Expression.BinaryExpression.*;
    import main.ast.nodes.Operators.*;
    import main.ast.nodes.Types.*;
    import main.ast.nodes.Expression.PostExpression.*;
    import main.ast.nodes.Expression.PreExpression.*;
    import main.ast.nodes.Stmt.SelectionStmt.*;
}

// parser
program returns [Program programRet]:
    {$programRet = new Program();} (t = translationUnit{$programRet.setTranslationUnit($t.translationUnitRet);})? EOF ;

translationUnit returns [TransUnit translationUnitRet]:
    {$translationUnitRet = new TransUnit();} (e = externalDeclaration{ if ($e.externalDeclarationRet != null) { $translationUnitRet.addExternalDeclaration($e.externalDeclarationRet);} } )+ ;

externalDeclaration returns [ExtDec externalDeclarationRet]:
    (f = functionDefinition { $externalDeclarationRet = $f.functionDefinitionRet;})
    | (d = declaration { $externalDeclarationRet = $d.declarationRet;})
    | Newline {$externalDeclarationRet = null;}; // stray ;

functionDefinition returns [FuncDef functionDefinitionRet]:
    {$functionDefinitionRet = new FuncDef();}
    (ds = declarationSpecifiers {
        $functionDefinitionRet.setDeclarationSpecifiers($ds.declarationSpecifiersRet);
    })?
    (d = declarator {
        $functionDefinitionRet.setDeclarator($d.declaratorRet);
        $functionDefinitionRet.setLine($d.declaratorRet.getLine());
    })
    (dl = declarationList {
        $functionDefinitionRet.setDeclarationList($dl.declarationListRet);
    })?
    (cs = compound {
        $functionDefinitionRet.setCompoundStatement($cs.compoundStatementRet);
    })
    (Newline | Tab)* End
    ;


declarationList returns [DecLst declarationListRet]:
    {$declarationListRet = new DecLst();} (d = declaration {$declarationListRet.addDeclaration($d.declarationRet);})+ ;

expression returns [Expression expressionRet]:
    e0=expression Tab+
    {
    $expressionRet = $e0.expressionRet;
    }
    |
    Tab+ e60 = expression
          {
               $expressionRet = $e60.expressionRet;
           }
    |
        e1=Identifier
        { $expressionRet = new IdentifierExpr(new Identifier($e1.text));
          $expressionRet.setLine($e1.line);
        }

    | e2=Constant
        { $expressionRet = new ConstVal($e2.text);
          $expressionRet.setLine($e2.line);
        }

    | e3=StringLiteral+
        { $expressionRet = new StrLiteralExp($e3.text);
          $expressionRet.setLine($e3.line);
        }

    | LeftParen e4=expression RightParen
        { $expressionRet = new ParanExpr($e4.expressionRet);
          $expressionRet.setLine($e4.expressionRet.getLine());
        }

    | LeftParen t1=typeName RightParen LeftBrace i1=initializerList Comma? RightBrace
        { $expressionRet = new CompoundLiteral($t1.typeNameRet, $i1.initializerListRet);
          $expressionRet.setLine($t1.typeNameRet.getLine());
        }

    | e5=expression LeftBracket e6=expression RightBracket
        { $expressionRet = new ArrAccess($e5.expressionRet, $e6.expressionRet);
          $expressionRet.setLine($e5.expressionRet.getLine());
        }

    | e7=expression
        { $expressionRet = new FunctionCall($e7.expressionRet);
          $expressionRet.setLine($e7.expressionRet.getLine());
        }
      LeftParen (e8=argumentExpressionList
        { $expressionRet.setArgumentExpressionList($e8.argumentExpressionListRet); }
      )? RightParen

    | e9=expression PlusPlus
        { $expressionRet = new PostInc($e9.expressionRet);
          $expressionRet.setLine($e9.expressionRet.getLine());
        }

    | e10=expression MinusMinus
        { $expressionRet = new PostDec($e10.expressionRet);
          $expressionRet.setLine($e10.expressionRet.getLine());
        }

    | {ArrayList<PreExpr> pes = new ArrayList<>(); }((pp = PlusPlus) { pes.add(new PreInc()); }| (mm =MinusMinus)  { pes.add(new PreDec()); }| (so = Sizeof) { pes.add(new PreSizeOf());})* (
          e1=Identifier
                  { $expressionRet = new IdentifierExpr(new Identifier($e1.text));
                    $expressionRet.setLine($e1.line);
                  }
        | e12=Constant
            { $expressionRet = new ConstVal($e12.text);
              $expressionRet.setLine($e12.line);
            }
        | e13=StringLiteral+
            { $expressionRet = new StrLiteralExp($e13.text);
              $expressionRet.setLine($e13.line);
            }
        | LeftParen e14=expression RightParen
            {
            $expressionRet = new ParanExpr($e14.expressionRet);
                      $expressionRet.setLine($e14.expressionRet.getLine());
                    }
        | LeftParen t2=typeName RightParen LeftBrace i2=initializerList Comma? RightBrace
            { $expressionRet = new CompoundLiteral($t2.typeNameRet, $i2.initializerListRet);
              $expressionRet.setLine($t2.typeNameRet.getLine());
            }
        | u1=unaryOperator e15=castExpression
            { $expressionRet = new UnaryExpr($u1.unaryOperatorRet, $e15.castExpressionRet);
              $expressionRet.setLine($u1.start.getLine());
            }
        | Sizeof LeftParen t3=typeName RightParen
            { $expressionRet = new SizeofType($t3.typeNameRet);
              $expressionRet.setLine($t3.typeNameRet.getLine());
            }
      ) {$expressionRet.setPreExpressions(pes);}

    | LeftParen t4=typeName RightParen e16=castExpression
        { $expressionRet = new CastExprExpr($t4.typeNameRet, $e16.castExpressionRet);
          $expressionRet.setLine($t4.typeNameRet.getLine());
        }

    | e17=expression {String bo;} ((Star {bo =  "*";}) | Div {bo = "/";} | Mod {bo = "%";}) e18=expression
        { $expressionRet = new BinaryExpr($e17.expressionRet, bo, $e18.expressionRet);
          $expressionRet.setLine($e17.expressionRet.getLine());
        }

    | e23=expression {String bo;} (Plus {bo = "+";} | Minus {bo = "-";}) e24=expression
        { $expressionRet = new BinaryExpr($e23.expressionRet, bo, $e24.expressionRet);
          $expressionRet.setLine($e23.expressionRet.getLine());
        }

    | e27=expression {String bo;} (LeftShift {bo = "<<";}| RightShift {bo = ">>";})  e28=expression
        { $expressionRet = new BinaryExpr($e27.expressionRet, bo, $e28.expressionRet);
          $expressionRet.setLine($e27.expressionRet.getLine());
        }

    | e31=expression {String bo;} (Less {bo = "<";}| Greater {bo = ">";}| LessEqual {bo = "<=";}| GreaterEqual {bo = ">=";}) e32=expression
        { $expressionRet = new BinaryExpr($e31.expressionRet, bo, $e32.expressionRet);
          $expressionRet.setLine($e31.expressionRet.getLine());
        }

    | e39=expression {String bo;} (Equal {bo = "==";} | NotEqual {bo = "!=";}) e40=expression
        { $expressionRet = new BinaryExpr($e39.expressionRet, bo, $e40.expressionRet);
          $expressionRet.setLine($e39.expressionRet.getLine());
        }

    | e43=expression And e44=expression
        { $expressionRet = new BinaryExpr($e43.expressionRet, "&", $e44.expressionRet);
          $expressionRet.setLine($e43.expressionRet.getLine());
        }

    | e45=expression Xor e46=expression
        { $expressionRet = new BinaryExpr($e45.expressionRet, "^", $e46.expressionRet);
          $expressionRet.setLine($e45.expressionRet.getLine());
        }

    | e47=expression Or e48=expression
        { $expressionRet = new BinaryExpr($e47.expressionRet, "|", $e48.expressionRet);
          $expressionRet.setLine($e47.expressionRet.getLine());
        }

    | e49=expression AndAnd e50=expression
        { $expressionRet = new BinaryExpr($e49.expressionRet, "&&", $e50.expressionRet);
          $expressionRet.setLine($e49.expressionRet.getLine());
        }

    | e51=expression OrOr e52=expression
        { $expressionRet = new BinaryExpr($e51.expressionRet, "||", $e52.expressionRet);
          $expressionRet.setLine($e51.expressionRet.getLine());
        }

    | e53=expression Question e54=expression Colon e55=expression
        { $expressionRet = new CondExpr($e53.expressionRet, $e54.expressionRet, $e55.expressionRet);
          $expressionRet.setLine($e53.expressionRet.getLine());
        }

    | e56=expression op1=assignmentOperator e57=expression
        { $expressionRet = new AssignExpr($op1.assignmentOperatorRet, $e56.expressionRet, $e57.expressionRet);
          $expressionRet.setLine($e56.expressionRet.getLine());
        }

    | e58=expression
        { $expressionRet = new CommaExpr();
          $expressionRet.addExpression($e58.expressionRet);
          $expressionRet.setLine($e58.expressionRet.getLine());
        }
      (Comma e59=expression
        { $expressionRet.addExpression($e59.expressionRet); })
    +
    ;



argumentExpressionList returns [ArgExprLst argumentExpressionListRet]:
    {$argumentExpressionListRet = new ArgExprLst();}
    (e = expression {$argumentExpressionListRet.addExpression($e.expressionRet);})
    (Comma (e1 = expression) {$argumentExpressionListRet.addExpression($e1.expressionRet);})* ;

unaryOperator returns [Unary unaryOperatorRet]:
    And {$unaryOperatorRet = new Unary("&");}
    | Star {$unaryOperatorRet = new Unary("*");}
    | Plus {$unaryOperatorRet = new Unary("++");}
    | Minus {$unaryOperatorRet = new Unary("--");}
    | Tilde {$unaryOperatorRet = new Unary("~");}
    | Not {$unaryOperatorRet = new Unary("!");}
    ;

castExpression returns [CastExpression castExpressionRet]:
    LeftParen (tn = typeName) RightParen (ce = castExpression) {$castExpressionRet = new CastExpressionAgain($tn.typeNameRet, $ce.castExpressionRet);}
    | (e = expression) {$castExpressionRet = new CastExprAlone($e.expressionRet);}
    | (ds = DigitSequence) {$castExpressionRet = new DigitSeq($ds.text);}
    ;

assignmentOperator returns [AssignOp assignmentOperatorRet]:
    Assign {$assignmentOperatorRet = new AssignOp("=");}
    | StarAssign {$assignmentOperatorRet = new AssignOp("*=");}
    | DivAssign {$assignmentOperatorRet = new AssignOp("/=");}
    | ModAssign {$assignmentOperatorRet = new AssignOp("%=");}
    | PlusAssign {$assignmentOperatorRet = new AssignOp("+=");}
    | MinusAssign {$assignmentOperatorRet = new AssignOp("-=");}
    | LeftShiftAssign {$assignmentOperatorRet = new AssignOp("<<=");}
    | RightShiftAssign {$assignmentOperatorRet = new AssignOp(">>=");}
    | AndAssign {$assignmentOperatorRet = new AssignOp("&=");}
    | XorAssign {$assignmentOperatorRet = new AssignOp("^=");}
    | OrAssign {$assignmentOperatorRet = new AssignOp("|=");}
    ;

declaration returns [Declaration declarationRet]:
    {$declarationRet = new Declaration();}
    (dss = declarationSpecifiers {$declarationRet.setDss($dss.declarationSpecifiersRet);}) Tab*
    (idl = initDeclaratorList {$declarationRet.setIdl($idl.initDeclaratorListRet);})?  {$declarationRet.setLine($dss.declarationSpecifiersRet.getLine());} Newline;

declarationSpecifiers returns [DeclarationSpecs declarationSpecifiersRet]:
    {$declarationSpecifiersRet = new DeclarationSpecs();}
    (ds = declarationSpecifier {$declarationSpecifiersRet.addDeclarationSpecifier($ds.declarationSpecifierRet); $declarationSpecifiersRet.setLine($ds.declarationSpecifierRet.getLine());})+ ;

declarationSpecifier returns [DeclarationSpec declarationSpecifierRet]:
    (t = Typedef {$declarationSpecifierRet = new TypeDef(); $declarationSpecifierRet.setLine($t.line);})
    | (ts = typeSpecifier {$declarationSpecifierRet = $ts.typeSpecifierRet;} )
    | (c = Const {$declarationSpecifierRet = new Const(); $declarationSpecifierRet.setLine($c.line);}) ;

initDeclaratorList returns [InitDecLst initDeclaratorListRet]:
    {$initDeclaratorListRet = new InitDecLst();}
    (id = initDeclarator {$initDeclaratorListRet.addInitDeclarator($id.initDeclaratorRet); $initDeclaratorListRet.setLine($id.initDeclaratorRet.getLine());} )
    (Tab* Comma (id1 = initDeclarator {$initDeclaratorListRet.addInitDeclarator($id1.initDeclaratorRet);}))* ;

initDeclarator returns [InitDec initDeclaratorRet]:
    {$initDeclaratorRet = new InitDec();}
    (d = declarator {$initDeclaratorRet.setDeclarator($d.declaratorRet); $initDeclaratorRet.setLine($d.declaratorRet.getLine());})
    (Tab* Assign (i = initializer {$initDeclaratorRet.setInitializer($i.initializerRet);}))? ;

typeSpecifier returns [TypeSpec typeSpecifierRet]:
    (v = Void {$typeSpecifierRet = new Void_(); $typeSpecifierRet.setLine($v.line);})
    | (c = Char {$typeSpecifierRet = new Char_(); $typeSpecifierRet.setLine($c.line);})
    | (sh = Short {$typeSpecifierRet = new Short_(); $typeSpecifierRet.setLine($sh.line);})
    | (i = Int {$typeSpecifierRet = new Int_(); $typeSpecifierRet.setLine($i.line);})
    | (l = Long {$typeSpecifierRet = new Long_(); $typeSpecifierRet.setLine($l.line);})
    | (f = Float {$typeSpecifierRet = new Float_(); $typeSpecifierRet.setLine($f.line);})
    | (d = Double {$typeSpecifierRet = new Double_(); $typeSpecifierRet.setLine($d.line);})
    | (s = Signed {$typeSpecifierRet = new Signed_(); $typeSpecifierRet.setLine($s.line);})
    | (us = Unsigned {$typeSpecifierRet = new Unsigned_(); $typeSpecifierRet.setLine($us.line);})
    | (b = Bool {$typeSpecifierRet = new Bool_(); $typeSpecifierRet.setLine($b.line);})
    | (id = Identifier {$typeSpecifierRet = new Identifier($id.text); $typeSpecifierRet.setLine($id.line);}) ;

specQualifierLst returns [SpecQualifierLst specifierQualifierListRet]:
    {$specifierQualifierListRet = new SpecQualifierLst1();}
    ((ts = typeSpecifier {$specifierQualifierListRet.setDeclarationSpecifier($ts.typeSpecifierRet); $specifierQualifierListRet.setLine($ts.typeSpecifierRet.getLine());})
    | (c = Const {$specifierQualifierListRet = new SpecQualifierLst2(new Const()); $specifierQualifierListRet.setLine($c.line);}))
    (sql = specQualifierLst {$specifierQualifierListRet.setSpecifierQualifierListOptional($sql.specifierQualifierListRet);})?
    ;

declarator returns [Declarator declaratorRet]:
    {$declaratorRet = new Declarator();}
    (p = pointer {$declaratorRet.setPointer($p.pointerRet);})?
    (dd = directDeclarator {$declaratorRet.setDirectDeclarator($dd.directDeclaratorRet); $declaratorRet.setLine($dd.directDeclaratorRet.getLine());}) ;

directDeclarator returns [DirectDec directDeclaratorRet]:
    (id = Identifier {$directDeclaratorRet = new Identifier($id.text); $directDeclaratorRet.setLine($id.line);})
    | LeftParen (d = declarator {$directDeclaratorRet = $d.declaratorRet;}) RightParen
    |  dd1 = directDeclarator {$directDeclaratorRet = new DirectDec1(); $directDeclaratorRet.setLine($dd1.directDeclaratorRet.getLine());} {$directDeclaratorRet.setDirectDeclarator($dd1.directDeclaratorRet);}
    LeftBracket (e = expression {$directDeclaratorRet.setExpression($e.expressionRet);})? RightBracket
    |  dd2 = directDeclarator {$directDeclaratorRet = new DirectDec2(); $directDeclaratorRet.setLine($dd2.directDeclaratorRet.getLine());} {$directDeclaratorRet.setDirectDeclarator($dd2.directDeclaratorRet);}
    LeftParen  ((pl = parameterList {$directDeclaratorRet.setSomeList($pl.parameterListRet);})
    | (il = identifierList {$directDeclaratorRet.setSomeList($il.identifierListRet);})?) RightParen ;

pointer returns [Pointer pointerRet]:
    {$pointerRet = new Pointer();}
    (
    { ArrayList<Const> arr = new ArrayList<>();}
    (s = Star {$pointerRet.setLine($s.line);})
    ((c = Const {arr.add(new Const());})+)? {
    $pointerRet.addPoint(new Pair<Star, ArrayList<Const>>(new Star(), arr));
    }
    )+ ;

parameterList returns [ParamLst parameterListRet]:
    {$parameterListRet = new ParamLst();}
    (pd = parameterDeclaration {$parameterListRet.addParameterDeclaration($pd.parameterDeclarationRet);})
    (Comma (pd1 = parameterDeclaration) {$parameterListRet.addParameterDeclaration($pd1.parameterDeclarationRet);})* ;

parameterDeclaration returns [ParameterDeclaration parameterDeclarationRet]:
    ds=declarationSpecifiers d=declarator
        {
            $parameterDeclarationRet = new ParameterDeclarationType1(
                $ds.declarationSpecifiersRet,
                $d.declaratorRet
            );
            $parameterDeclarationRet.setLine($d.declaratorRet.getLine());
        }

    | ds=declarationSpecifiers
     {
                 $parameterDeclarationRet = new ParamDec2(
                     $ds.declarationSpecifiersRet
                 );
                 $parameterDeclarationRet.setLine($ds.declarationSpecifiersRet.getLine());
     }
      (ad=abstractDeclarator {$parameterDeclarationRet.setAbstractDeclarator($ad.abstractDeclaratorRet);}) ?

    ;


identifierList returns [IdentifierLst identifierListRet]:
    {$identifierListRet = new IdentifierLst();}
    (id = Identifier {$identifierListRet.addIdentifier(new Identifier($id.text)); $identifierListRet.setLine($id.line);})
    (Comma id1 = Identifier {$identifierListRet.addIdentifier(new Identifier($id1.text));})*
    ;

typeName returns [TypeName typeNameRet]:
    {$typeNameRet = new TypeName();}
    (sql = specQualifierLst {$typeNameRet.setSpecifierQualifierList($sql.specifierQualifierListRet); $typeNameRet.setLine($sql.specifierQualifierListRet.getLine());})
    (ad = abstractDeclarator {$typeNameRet.setAbstractDeclarator($ad.abstractDeclaratorRet);})?
    ;

abstractDeclarator returns [AbstractDeclarator abstractDeclaratorRet]:
    (p = pointer {$abstractDeclaratorRet = new AbstDeclaratorPointer($p.pointerRet); $abstractDeclaratorRet.setLine($p.pointerRet.getLine());})
    | {$abstractDeclaratorRet = new AbstractDeclaratorDirect();} (p = pointer {$abstractDeclaratorRet.setPointer($p.pointerRet);})? (dad = directAbstractDeclarator) {$abstractDeclaratorRet.setDirectAbstractDeclarator($dad.directAbstractDeclaratorRet); $abstractDeclaratorRet.setLine($dad.directAbstractDeclaratorRet.getLine());}
    ;

directAbstractDeclarator returns [DirectAbstDec directAbstractDeclaratorRet]:
    {$directAbstractDeclaratorRet = new DirectAbstDec1();} (lb =LeftBracket {$directAbstractDeclaratorRet.setLine($lb.line);}) (e = expression { $directAbstractDeclaratorRet.setExpression($e.expressionRet);})? RightBracket
    | {$directAbstractDeclaratorRet = new DirectAbstDec2();} (lp = LeftParen {$directAbstractDeclaratorRet.setLine($lp.line);})  (ad = abstractDeclarator { $directAbstractDeclaratorRet.setAbstractDeclarator($ad.abstractDeclaratorRet);}) RightParen
    | {$directAbstractDeclaratorRet = new DirectAbstDec3();} (lp = LeftParen {$directAbstractDeclaratorRet.setLine($lp.line);})  (pl = parameterList { $directAbstractDeclaratorRet.setParameterList($pl.parameterListRet);})?  RightParen
    |  dad1 = directAbstractDeclarator {$directAbstractDeclaratorRet = new DirectAbstDec4(); $directAbstractDeclaratorRet.setDirectAbstractDeclarator($dad1.directAbstractDeclaratorRet);} (lb = LeftBracket {$directAbstractDeclaratorRet.setLine($lb.line);}) (e2 = expression { $directAbstractDeclaratorRet.setExpression($e2.expressionRet);})? RightBracket
    | dad2 = directAbstractDeclarator  {$directAbstractDeclaratorRet = new DirectAbstDec5(); $directAbstractDeclaratorRet.setDirectAbstractDeclarator($dad2.directAbstractDeclaratorRet);} (lp = LeftParen {$directAbstractDeclaratorRet.setLine($lp.line);}) (pl2 = parameterList { $directAbstractDeclaratorRet.setParameterList($pl2.parameterListRet);})? RightParen ;

initializer returns [Initializer initializerRet]:
    (e = expression {$initializerRet = $e.expressionRet;})
    | LeftBrace (il = initializerList {$initializerRet = $il.initializerListRet;}) Comma? RightBrace ;

initializerList returns [InitLst initializerListRet]:
    {$initializerListRet = new InitLst();}
    {
        Designation d2 = null;
        Designation d3 = null;
    }
    ( (d = designation {d2 = $d.designationRet;})? i =initializer {$initializerListRet.setLine($i.initializerRet.getLine());}
    {$initializerListRet.addInitializerList(new Pair<Designation, Initializer>(d2, $i.initializerRet));})
    (Comma ((d1 = designation {d3 = $d1.designationRet;})? i1 = initializer)
    {$initializerListRet.addInitializerList(new Pair<Designation, Initializer>(d3, $i1.initializerRet));})* ;

designation returns [Designation designationRet]:
    {$designationRet = new Designation();} (d = designator {$designationRet.addDesignator($d.designatorRet);})+
    (a = Assign) {$designationRet.setLine($a.line);} ;

designator returns [Designator designatorRet]:
    LeftBracket (e = expression {$designatorRet = $e.expressionRet;}) RightBracket
    | Dot (id = Identifier {$designatorRet = new Identifier($id.text);}) ;

statement returns [Statement statementRet]:
    (cs = compound) {$statementRet = $cs.compoundStatementRet; $statementRet.setLine($cs.compoundStatementRet.getLine());}
    | (es = expressionStatement) {$statementRet = $es.expressionStatementRet; $statementRet.setLine($es.expressionStatementRet.getLine());}
    | (ss = selectionStatement) {$statementRet = $ss.selectionStatementRet; $statementRet.setLine($ss.selectionStatementRet.getLine());}
    | (is = iterationStatement) {$statementRet = $is.iterationStatementRet; $statementRet.setLine($is.iterationStatementRet.getLine()); }
    | (js = jumpStatement) {$statementRet = $js.jumpStatementRet; $statementRet.setLine($js.jumpStatementRet.getLine());};

compound returns [Compound compoundStatementRet]:
    {$compoundStatementRet = new Compound();}
    Tab* (lb = Colon) ((bi = blockItem {$compoundStatementRet.addBlockItem($bi.blockItemRet);})+)?
    {$compoundStatementRet.setLine($lb.line);} ;

blockItem returns [BlockItem blockItemRet]:
    {int tabs = 0;} ( Newline { tabs = 0;} | Tab {tabs = tabs + 1;} )*  (s = statement {$blockItemRet = $s.statementRet;}) { $s.statementRet.setTabs(tabs);}
    | {int tabs = 0;} ( Newline { tabs = 0;} | Tab {tabs = tabs + 1;} )* (d = declaration) {$blockItemRet = $d.declarationRet;} { $d.declarationRet.setTabs(tabs);}
    ;

expressionStatement returns [Expr expressionStatementRet]:
    {$expressionStatementRet = new Expr();}
    (e = expression {$expressionStatementRet.setExpression($e.expressionRet);})  (nl = Newline) {$expressionStatementRet.setLine($nl.line);} ;

selectionStatement returns [Selection selectionStatementRet]:
    (i = If) Tab* LeftParen
    (e = expression )
    RightParen Tab* Colon Tab* Newline
    {
        $selectionStatementRet = new IF($e.expressionRet);
        $selectionStatementRet.setLine($i.line);
    }
    |
    (el = Elif) Tab* LeftParen
    (e2 = expression)
    RightParen Tab* Colon Tab* Newline
    {
            $selectionStatementRet = new Elif($e2.expressionRet);
            $selectionStatementRet.setLine($el.line);
    }
    |
    (ee = Else) Tab* Colon Tab* Newline
    {
                $selectionStatementRet = new Else();
                $selectionStatementRet.setLine($ee.line);
    }
     ;

iterationStatement returns [Iter iterationStatementRet]:
    (w = While) Tab* LeftParen e1 = expression RightParen  Tab* Colon Tab* Newline
    {
    $iterationStatementRet = new While($e1.expressionRet);
    $iterationStatementRet.setLine($w.line);
    }
    | (d = Do)  s2 = statement (Newline | Tab)* While Tab* LeftParen e2 = expression RightParen Tab* Newline
    {
    $iterationStatementRet = new DoWhile($e2.expressionRet, $s2.statementRet);
    $iterationStatementRet.setLine($d.line);
    }
    | (f = For) LeftParen fc = forCondition RightParen Tab* Colon Tab* Newline
    {
    $iterationStatementRet = new For($fc.forConditionRet);
    $iterationStatementRet.setLine($f.line);
    }
    ;

forCondition returns [ForCond forConditionRet]:
    (fd = forDeclaration) Tab* (s1 = Semi) Tab* {ForExpr ffe1 = null;}(fe1 = forExpression {ffe1 = $fe1.forExpressionRet;} )?
     Tab* Semi Tab* {ForExpr ffe2 = null;} (fe2 = forExpression {ffe2 = $fe2.forExpressionRet;})? {
    $forConditionRet = new ForCond1();
    $forConditionRet.setForDeclaration($fd.forDeclarationRet);
    $forConditionRet.setForExpression1(ffe1);
    $forConditionRet.setForExpression2(ffe2);
    $forConditionRet.setLine($s1.line);
    }
    | {Expression ee = null;}(e = expression {ee = $e.expressionRet;})? Tab* (s2 = Semi) Tab* {ForExpr ffe3 = null;} (fe3 = forExpression {ffe3 = $fe3.forExpressionRet;})?
    Tab* Semi Tab* {ForExpr ffe4 = null;} (fe4 = forExpression {ffe4 = $fe4.forExpressionRet;})? {
    $forConditionRet = new ForCond2();
    $forConditionRet.setExpression(ee);
    $forConditionRet.setForExpression1(ffe3);
    $forConditionRet.setForExpression2(ffe4);
    $forConditionRet.setLine($s2.line);
    }
    ;

forDeclaration returns [ForDec forDeclarationRet]:
    {$forDeclarationRet = new ForDec();}
    (dss = declarationSpecifiers {
        $forDeclarationRet.setDeclarationSpecifiers($dss.declarationSpecifiersRet);
        $forDeclarationRet.setLine($dss.declarationSpecifiersRet.getLine());
    })
    (idl = initDeclaratorList {
        $forDeclarationRet.setInitDeclaratorList($idl.initDeclaratorListRet);
    })? ;

forExpression returns [ForExpr forExpressionRet]:
    {$forExpressionRet = new ForExpr();} (e = expression {$forExpressionRet.addExpression($e.expressionRet); $forExpressionRet.setLine($e.expressionRet.getLine());})
    (Comma (e1 = expression) {$forExpressionRet.addExpression($e1.expressionRet);})* ;

jumpStatement returns [Jump jumpStatementRet]
    : (
    (c = Continue {$jumpStatementRet = new Continue(); $jumpStatementRet.setLine($c.line);}) Newline
    | (b = Break {$jumpStatementRet = new Break(); $jumpStatementRet.setLine($b.line);}) Newline
    | (r = Return {$jumpStatementRet = new Return(); $jumpStatementRet.setLine($r.line);} (e = expression {$jumpStatementRet.setExpression($e.expressionRet);})?) Newline
    )  ;


// lexer
Break                 : 'break'                 ;
Char                  : 'char'                  ;
Const                 : 'const'                 ;
Continue              : 'continue'              ;
Do                    : 'do'                    ;
Double                : 'double'                ;
Else                  : 'else'                  ;
Float                 : 'float'                 ;
For                   : 'for'                   ;
If                    : 'if'                    ;
Int                   : 'int'                   ;
Long                  : 'long'                  ;
Return                : 'return'                ;
Short                 : 'short'                 ;
Signed                : 'signed'                ;
Sizeof                : 'sizeof'                ;
Switch                : 'switch'                ;
Typedef               : 'typedef'               ;
Unsigned              : 'unsigned'              ;
Void                  : 'void'                  ;
While                 : 'while'                 ;
Bool                  : 'bool'                  ;
LeftParen             : '('                     ;
RightParen            : ')'                     ;
LeftBracket           : '['                     ;
RightBracket          : ']'                     ;
LeftBrace             : '{'                     ;
RightBrace            : '}'                     ;
Less                  : '<'                     ;
LessEqual             : '<='                    ;
Greater               : '>'                     ;
GreaterEqual          : '>='                    ;
LeftShift             : '<<'                    ;
RightShift            : '>>'                    ;
Plus                  : '+'                     ;
PlusPlus              : '++'                    ;
Minus                 : '-'                     ;
MinusMinus            : '--'                    ;
Star                  : '*'                     ;
Div                   : '/'                     ;
Mod                   : '%'                     ;
And                   : '&'                     ;
Or                    : '|'                     ;
AndAnd                : '&&'                    ;
OrOr                  : '||'                    ;
Xor                   : '^'                     ;
Not                   : '!'                     ;
Tilde                 : '~'                     ;
Question              : '?'                     ;
Colon                 : ':'                     ;
Semi                  : ';'                     ;
Comma                 : ','                     ;
Assign                : '='                     ;
StarAssign            : '*='                    ;
DivAssign             : '/='                    ;
ModAssign             : '%='                    ;
PlusAssign            : '+='                    ;
MinusAssign           : '-='                    ;
LeftShiftAssign       : '<<='                   ;
RightShiftAssign      : '>>='                   ;
AndAssign             : '&='                    ;
XorAssign             : '^='                    ;
OrAssign              : '|='                    ;
Equal                 : '=='                    ;
NotEqual              : '!='                    ;
Arrow                 : '->'                    ;
Dot                   : '.'                     ;
End                   : 'end'                   ;
Elif                  : 'else if'               ;
Identifier
    : IdentifierNondigit (IdentifierNondigit | Digit)* ;

fragment IdentifierNondigit
    : Nondigit | UniversalCharacterName ;

fragment Nondigit
    : [a-zA-Z_] ;

fragment Digit
    : [0-9] ;

fragment UniversalCharacterName
    : '\\u' HexQuad | '\\U' HexQuad HexQuad ;

fragment HexQuad
    : HexadecimalDigit HexadecimalDigit HexadecimalDigit HexadecimalDigit ;

Constant
    : IntegerConstant | FloatingConstant | CharacterConstant ;

fragment IntegerConstant
    : DecimalConstant IntegerSuffix?
    | OctalConstant IntegerSuffix?
    | HexadecimalConstant IntegerSuffix?
    | BinaryConstant ;

fragment BinaryConstant
    : '0' [bB] [0-1]+ ;

fragment DecimalConstant
    : NonzeroDigit Digit* ;

fragment OctalConstant
    : '0' OctalDigit* ;

fragment HexadecimalConstant
    : HexadecimalPrefix HexadecimalDigit+ ;

fragment HexadecimalPrefix
    : '0' [xX] ;

fragment NonzeroDigit
    : [1-9] ;

fragment OctalDigit
    : [0-7] ;

fragment HexadecimalDigit
    : [0-9a-fA-F] ;

fragment IntegerSuffix
    : UnsignedSuffix LongSuffix? | UnsignedSuffix LongLongSuffix | LongSuffix UnsignedSuffix? | LongLongSuffix UnsignedSuffix? ;

fragment UnsignedSuffix
    : [uU] ;

fragment LongSuffix
    : [lL] ;

fragment LongLongSuffix
    : 'll' | 'LL' ;

fragment FloatingConstant
    : DecimalFloatingConstant | HexadecimalFloatingConstant ;

fragment DecimalFloatingConstant
    : FractionalConstant ExponentPart? FloatingSuffix? | DigitSequence ExponentPart FloatingSuffix? ;

fragment HexadecimalFloatingConstant
    : HexadecimalPrefix (HexadecimalFractionalConstant | HexadecimalDigitSequence) BinaryExponentPart FloatingSuffix? ;

fragment FractionalConstant
    : DigitSequence? Dot DigitSequence | DigitSequence Dot ;

fragment ExponentPart
    : [eE] Sign? DigitSequence ;

fragment Sign
    : [+-] ;

DigitSequence
    : Digit+ ;

fragment HexadecimalFractionalConstant
    : HexadecimalDigitSequence? Dot HexadecimalDigitSequence | HexadecimalDigitSequence Dot ;

fragment BinaryExponentPart
    : [pP] Sign? DigitSequence ;

fragment HexadecimalDigitSequence
    : HexadecimalDigit+ ;

fragment FloatingSuffix
    : [flFL] ;

fragment CharacterConstant
    : '\'' CCharSequence '\'' | 'L\'' CCharSequence '\''| 'u\'' CCharSequence '\'' | 'U\'' CCharSequence '\''
    ;

fragment CCharSequence
    : CChar+ ;

fragment CChar
    : ~['\\\r\n] | EscapeSequence ;

fragment EscapeSequence
    : SimpleEscapeSequence | OctalEscapeSequence | HexadecimalEscapeSequence | UniversalCharacterName ;

fragment SimpleEscapeSequence
    : '\\' ['"?abfnrtv\\] ;

fragment OctalEscapeSequence
    : '\\' OctalDigit OctalDigit? OctalDigit? ;

fragment HexadecimalEscapeSequence
    : '\\x' HexadecimalDigit+ ;

StringLiteral
    : EncodingPrefix? '"' SCharSequence? '"' ;

fragment EncodingPrefix
    : 'u8' | 'u' | 'U' | 'L' ;

fragment SCharSequence
    : SChar+ ;

fragment SChar
    : ~["\\\r\n] | EscapeSequence | '\\\n' | '\\\r\n' ;

MultiLineMacro
    : '#' (~[\n]*? '\\' '\r'? '\n')+ ~ [\n]+ -> channel(HIDDEN) ;

Directive
    : '#' ~[\n]* -> channel(HIDDEN) ;

Newline
    : ('\r' '\n'? | '\n') ;

Tab
    : ('    ' | [\t]);

Whitespace
    : [ ] -> channel(HIDDEN) ;

BlockComment
    : '/*' .*? '*/' -> channel(HIDDEN) ;

LineComment
    : '//' ~[\r\n]* -> channel(HIDDEN) ;