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
%token TINT, TCHAR, TFLOAT, TELSE, TIF, TSWTICH, TCASE, TDEFAULT, TRETURN, TBREAK, TWHILE, TDO, TFOR
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
		| TIF

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
