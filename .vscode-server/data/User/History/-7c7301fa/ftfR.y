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

Dec : VarDec			{printf("Dec -> VarDec");}
	| FuncDec			{printf("Dec -> FuncDec");}
	;

FuncDec : VarType TIDENTIFIER '(' Params ')' CpndStmt		{printf("FuncDec -> VarType %s ( Params ) CpndStmt", $1);}
        | VarType TIDENTIFIER '(' Params ')' ';'			{printf("FuncDec -> VarType %s ( Params );", $1);}
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

OpenStmt : ForOpenStmt									{printf();}
		| WhileOpenStmt									{printf();}
		| TIF '(' Expr ')' Stmt							{printf();}
		| TIF '(' Expr ')' MatchedStmt TELSE OpenStmt	{printf();}
		;

SwitchStmt : TSWITCH '(' Expr ')' '{' CaseList DefaultCase'}'	{printf();}

CaseList : CaseList TCASE TINTEGER ':' StmtList	{printf();}
		| TCASE TINTEGER ':' StmtList			{printf();}
		;

DefaultCase : TDEFAULT ':' StmtList	{printf();}
			| 						{printf();}
			;

ReturnStmt : TRETURN Expr ';'	{printf();}
			| TRETURN ';'		{printf();}
			;

BreakStmt : TBREAK ';'	{printf();}

ExprStmt : Expr ';'	{printf();}
		| ';'		{printf();}
		;

Expr : AssignExpr	{printf();}
	| SimpleExpr	{printf();}

AssignExpr : Variable '=' Expr		{printf();}
			| Variable '+=' Expr	{printf();}
			| Variable '-=' Expr	{printf();}
			| Variable '*=' Expr	{printf();}
			| Variable '/=' Expr	{printf();}
			| Variable '%=' Expr	{printf();}
			;

Variable : TIDENTIFIER '[' Expr ']'	{printf();}
		| AndExpr					{printf();}
		;

SimpleExpr : SimpleExpr '||' AndExpr	{printf();}
			| RelExpr					{printf();}
			;

AndExpr : AndExpr '&&' RelExpr			{printf();}
		| RelExpr						{printf();}
		;

RelExpr : RelExpr '<' AddExpr	{printf();}
		| RelExpr '<=' AddExpr	{printf();}
		| RelExpr '>' AddExpr	{printf();}
		| RelExpr '>=' AddExpr	{printf();}
		| RelExpr '==' AddExpr	{printf();}
		| RelExpr '!=' AddExpr	{printf();}
		| AddExpr
		;

AddExpr : AddExpr '+' Term		{printf();}
		| AddExpr '-' Term		{printf();}
		| Term					{printf();}
		;

Term : Term '*' Factor	{printf();}
	| Term '/' Factor	{printf();}
	| Term '%' Factor	{printf();}
	| Factor			{printf();}
	;

Factor : '(' Expr ')'		{printf();}
		| FunCall			{printf();}
		| '-' Factor		{printf();}
		| Variable			{printf();}
		| Variable IncDec	{printf();}
		| IncDec Variable	{printf();}
		| NumberLiteral		{printf();}
		;

NumberLiteral : TINTEGER	{printf();}
			| TREAL			{printf();}
			;

IncDec : '++'	{printf();}
		| '--'	{printf();}
		;

WhileMatchedStmt : TWHILE '(' Expr ')' MatchedStmt	{printf();}

WhileOpenStmt : TWHILE '(' Expr ')' OpenStmt		{printf();}

DoWhileStmt : TDO Stmt TWHILE '(' Expr ')'';'		{printf();}

ForMatchedStmt : TFOR '(' Expr ';' Expr ';' Expr ')' MatchedStmt	{printf();}

ForOpenStmt : TFOR '(' Expr ';' Expr ';' Expr ')' OpenStmt		{printf();}

FunCall : TIDENTIFIER '(' Arguments ')'		{printf();}

Arguments : ArgumentList	{printf();}
			| 				{printf();}
			;

ArgumentList : ArgumentList ',' Expr	{printf();}
			| ArgumentList ',' TSTRING	{printf();}
			| Expr						{printf();}
			| TSTRING					{printf();}
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
