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
Program : DecList		{printf("Program -> DecList\n");}

DecList : DecList Dec	{printf("DecList -> DecList Dec\n");}
		| Dec			{printf("DecList -> Dec\n");}
		;

Dec : VarDec			{printf("Dec -> VarDec\n");}
	| FuncDec			{printf("Dec -> FuncDec\n");}
	;

FuncDec : VarType TIDENTIFIER '(' Params ')' CpndStmt		{printf("FuncDec -> VarType %s ( Params ) CpndStmt\n", $1);}
        | VarType TIDENTIFIER '(' Params ')' ';'			{printf("FuncDec -> VarType %s ( Params );\n", $1);}
		| TVOID TIDENTIFIER '(' Params ')' CpndStmt			{printf("FuncDec -> %s %s ( Params ) CpndStmt\n", $1, $2);}
		| TVOID TIDENTIFIER '(' Params ')' ';'				{printf("FuncDec -> %s %s ( Params )\n", $1, $2);}
		;

Params : ParamList		{printf("Param -> ParamList\n");}
       | TVOID			{printf("Param -> %s\n", $1);}
	   | 				{printf("Param -> epsilon\n");}
	   ;

ParamList : ParamList ',' Param		{printf("ParamList -> ParamList , Param\n");}
			| Param					{printf("ParamList -> Param\n");}
			;

Param : VarType Value				{printf("Param -> VarType Value\n");}

CpndStmt : '{' LDecList StmtList '}'	{printf("{ LDecList StmtList }\n");}

LDecList : LDecList VarDec	{printf("LDecList -> LDecList VarDec\n");}
		| 					{printf("LDecList -> epsilon\n");}
		;

VarDec : VarType IDs ';'	{printf("VarDec -< VarType IDs ; \n");}

VarType : TINT			{printf("VarType -> int\n");}
		| TCHAR			{printf("VarType -> char\n");}
		| TFLOAT		{printf("VarType -> float\n");}
		;

IDs : IDs ',' Value		{printf("IDs -> IDs , Value\n");}
	| Value				{printf("IDs -> Value\n");}

Value : TIDENTIFIER '[' TINTEGER ']'	{printf("Value -> %s [ %d ] \n", $1, $2);}
	| TIDENTIFIER						{printf("Value -> %s\n", $1);}
	;

StmtList : StmtList Stmt				{printf("StmtList -> StmtList Stmt\n");}
		| 								{printf("StmtList -> epsilon\n");}
		;

Stmt : MatchedStmt						{printf("Stmt -> MatchedStmt\n");}
	| OpenStmt							{printf("Stmt -> OpenStmt\n");}
	;

MatchedStmt : ExprStmt							{printf("MatchedStmt -> ExprStmt\n");}
			| ForMatchedStmt					{printf("MatchedStmt -> ForMatchedStmt\n");}
			| WhileMatchedStmt					{printf("MatchedStmt -> WhileMatchedStmt\n");}
			| DoWhileStmt						{printf("MatchedStmt -> DoWhileStmt\n");}
			| ReturnStmt						{printf("MatchedStmt -> ReturnStmt\n");}
            | CpndStmt							{printf("MatchedStmt -> CpndStmt\n");}
            | BreakStmt							{printf("MatchedStmt -> BreakStmt\n");}
            | SwitchStmt						{printf("MatchedStmt -> SwitchStmt\n");}
			| TIF '(' Expr ')' MatchedStmt 		{printf("MatchedStmt -> if ( Expr ) MatchedStmt\n");}
			;

OpenStmt : ForOpenStmt									{printf("OpenStmt -> ForOpenStmt\n");}
		| WhileOpenStmt									{printf("OpenStmt -> WhileOpenStmt\n");}
		| TIF '(' Expr ')' Stmt							{printf("OpenStmt -> if ( Expr ) Stmt\n");}
		| TIF '(' Expr ')' MatchedStmt TELSE OpenStmt	{printf("if ( Expr ) MatchedStmt else OpenStmt\n");}
		;

SwitchStmt : TSWITCH '(' Expr ')' '{' CaseList DefaultCase'}'	{printf("SwitchStmt -> switch ( Expr ) { CaseList DefaultCase }\n");}

CaseList : CaseList TCASE TINTEGER ':' StmtList	{printf("CaseList -> CaseList case %d : StmtList\n", $1);}
		| TCASE TINTEGER ':' StmtList			{printf("CaseList -> case %d : StmtList\n", $1);}
		;

DefaultCase : TDEFAULT ':' StmtList	{printf("DefaultCase -> default : StmtList\n");}
			| 						{printf("DefaultCase -> epsilon\n");}
			;

ReturnStmt : TRETURN Expr ';'	{printf("ReturnStmt -> return Expr ; \n");}
			| TRETURN ';'		{printf("ReturnStmt -> return ; \n");}
			;

BreakStmt : TBREAK ';'	{printf("BreakStmt -> break ; \n");}

ExprStmt : Expr ';'	{printf("ExprStmt -> Expr ; \n");}
		| ';'		{printf("ExprStmt -> ; \n");}
		;

Expr : AssignExpr	{printf("Expr -> AssignExpr\n");}
	| SimpleExpr	{printf("Expr -> SimpleExpr\n");}

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
