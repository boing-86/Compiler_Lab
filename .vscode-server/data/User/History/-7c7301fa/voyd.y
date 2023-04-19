%{
	#include <stdio.h>
	#include <stdlib.h>
	int yylex(void);
	int yyerror(char* s);
%}
%union{
	int iVal;
	float rVal;
	char* sVal;
}
%token<iVal> TINTEGER
%token<rVal> TREAL
%token<sVal> TIDENTIFIER
%token TBREAK, TCASE, TDEFAULT, TDO, TELSE, TFOR, TIF, TRETURN, TSWITCH, TWHILE, TSTRING
%start Program

%%
Program : DecList		{printf("Program -> DecList");}

DecList : DecList Dec	{printf("DecList -> DecList Dec");}
		| Dec			{printf("DecList -> Dec");}
		;

Dec : VarDec			{printf();}
	| FuncDec			{printf();}
	;

FuncDec : VarType TIDENTIFIER '(' Params ')' CpndStmt
        | VarType TIDENTIFIER '(' Params ')' ';'
		| 'void' TIDENTIFIER '(' Params ')' CpndStmt
		| 'void' TIDENTIFIER '(' Params ')' ';'
		;

Params : ParamList
       | 'void'
	   | ;

ParamList : ParamList ',' Param
			| Param
			;

Param : VarType Value

CpndStmt : '{' LDecList StmtList '}'

LDecList : LDecList VarDec
		| ;

VarDec : VarType IDs ';'

VarType : 'int'
		| 'char'
		| 'float'
		;

IDs : IDs ',' Value
	| Value

Value : TIDENTIFIER '[' TINTEGER ']'
	| TIDENTIFIER
	;

StmtList : StmtList Stmt
		| ;

Stmt : MatchedStmt
	| OpenStmt
	;

MatchedStmt : ExprStmt
			| ForMatchedStmt
			| WhileMatchedStmt
			| DoWhileStmt
			| ReturnStmt
            | CpndStmt
            | BreakStmt
            | SwitchStmt
			| TIF '(' Expr ')' MatchedStmt 
			;

OpenStmt : ForOpenStmt
		| WhileOpenStmt
		| TIF '(' Expr ')' Stmt
		| TIF '(' Expr ')' MatchedStmt TELSE OpenStmt
		;

SwitchStmt : TSWITCH '(' Expr ')' '{' CaseList DefaultCase'}'

CaseList : CaseList TCASE TINTEGER ':' StmtList
		| TCASE TINTEGER ':' StmtList
		;

DefaultCase : TDEFAULT ':' StmtList
			| ;

ReturnStmt : TRETURN Expr ';'
			| TRETURN ';'
			;

BreakStmt : TBREAK ';'

ExprStmt : Expr ';'
		| ';'
		;

Expr : AssignExpr
	| SimpleExpr

AssignExpr : Variable '=' Expr
			| Variable '+=' Expr
			| Variable '-=' Expr
			| Variable '*=' Expr
			| Variable '/=' Expr
			| Variable '%=' Expr
			;

Variable : TIDENTIFIER '[' Expr ']'
		| AndExpr
		;

AndExpr : AndExpr '&&' RelExpr
		| RelExpr
		;

RelExpr : RelExpr '<' AddExpr
		| RelExpr '<=' AddExpr
		| RelExpr '>' AddExpr
		| RelExpr '>=' AddExpr
		| RelExpr '==' AddExpr
		| RelExpr '!=' AddExpr
		| AddExpr
		;

AddExpr : AddExpr '+' Term
		| AddExpr '-' Term
		| Term
		;

Term : Term '*' Factor
	| Term '/' Factor
	| Term '%' Factor
	| Factor
	;

Factor : '(' Expr ')'
		| FunCall
		| '-' Factor
		| Variable
		| Variable IncDec
		| IncDec Variable
		| NumberLiteral
		;

NumberLiteral : TINTEGER
			| TREAL
			;

IncDec : '++'
		| '--'
		;

WhileMatchedStmt : TWHILE '(' Expr ')' MatchedStmt

WhileOpenStmt : TWHILE '(' Expr ')' OpenStmt

DoWhileStmt : TDO Stmt TWHILE '(' Expr ')'';'

ForMatchedStmt : TFOR '(' Expr ';' Expr ';' Expr ')' MatchedStmt

ForOpenStmt : TFOR '(' Expr ';' Expr ';' Expr ')' OpenStmt

FunCall : TIDENTIFIER '(' Arguments ')'

Arguments : ArgumentList
			| 
			;

ArgumentList : ArgumentList ',' Expr
			| ArgumentList ',' STRING 



%%
int main(int argc, char* argv[]){
	extern FILE *yyin;
	yyin = fopen(argv[1], "r");
	yyparse();
	fclose(yyin);
	return 0;
}

int yyerror(char *s){
	printf("Parse error : %s\n", s);
	return 0;
}
