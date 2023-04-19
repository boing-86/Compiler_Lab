%{
	#include <stdio.h>
	#include <stdlib.h>
	int yylex(void);
	int yyerror(char* s);
%}
%union{
	int iVal;
	float rVal;
	char* idVal;
	char* sVal;
}
%token<iVal> TINTEGER
%token<rVal> TREAL
%token<idVal> TIDENTIFIER
%token<sVal> TSTRING
%token TBREAK, TCASE, TDEFAULT, TDO, TELSE, TFOR, TIF, TRETURN, TSWITCH, TWHILE, TCHAR, TFLOAT, TINT, TVOID
%start Program

%%
Program : DecList		{printf("Program -> DecList");}

DecList : DecList Dec	{printf("DecList -> DecList Dec");}
		| Dec			{printf("DecList -> Dec");}
		;

Dec : VarDec			{printf(Dec -> VarDEC);}
	| FuncDec			{printf();}
	;

FuncDec : VarType TIDENTIFIER '(' Params ')' CpndStmt		{printf();}
        | VarType TIDENTIFIER '(' Params ')' ';'			{printf();}
		| TVOID TIDENTIFIER '(' Params ')' CpndStmt			{printf();}
		| TVOID TIDENTIFIER '(' Params ')' ';'				{printf();}
		;

Params : ParamList		{printf();}
       | TVOID			{printf();}
	   | 				{printf();}
	   ;

ParamList : ParamList ',' Param		{printf();}
			| Param					{printf();}
			;

Param : VarType Value				{printf();}

CpndStmt : '{' LDecList StmtList '}'	{printf();}

LDecList : LDecList VarDec	{printf();}
		| 					{printf();}
		;

VarDec : VarType IDs ';'	{printf();}

VarType : TINT			{printf();}
		| TCHAR			{printf();}
		| TFLOAT		{printf();}
		;

IDs : IDs ',' Value		{printf();}
	| Value				{printf();}

Value : TIDENTIFIER '[' TINTEGER ']'	{printf();}
	| TIDENTIFIER						{printf();}
	;

StmtList : StmtList Stmt				{printf();}
		| 								{printf();}
		;

Stmt : MatchedStmt						{printf();}
	| OpenStmt							{printf();}
	;

MatchedStmt : ExprStmt							{printf();}
			| ForMatchedStmt					{printf();}
			| WhileMatchedStmt					{printf();}
			| DoWhileStmt						{printf();}
			| ReturnStmt						{printf();}
            | CpndStmt							{printf();}
            | BreakStmt							{printf();}
            | SwitchStmt						{printf();}
			| TIF '(' Expr ')' MatchedStmt 		{printf();}
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
			| 
			;

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

SimpleExpr : SimpleExpr '||' AndExpr
			| RelExpr
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
			| ArgumentList ',' TSTRING
			| Expr
			| TSTRING
			;



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
