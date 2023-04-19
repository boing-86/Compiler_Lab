%{
    #include <stdio.h>
    int yylex(void);
    int yyerror(char*);
%}
%union{
    int iVal;
    float rVal;
    char* sVal;
}
%token<iVal> TINTEGER
%token<rVal> TREAL
%token<sVal> TIDENTIFIER
%token TOPERATOR
%start ExprStmt
%%
 // 문법 쓰기. yylval 도 받아옴!


ExprStmt : Expr ';'     {printf("ExprStmt -> Expr;\n");}
		| ';'           {printf("ExprStmt -> ;\n");}
		;

Expr : SimpleExpr        {printf("Expr -> AssignExpr;\n");}


Variable : TIDENTIFIER '[' Expr ']'
		| AndExpr
		;

SimpleExpr : SimpleExpr '||' AndExpr
			| RelExpr
			;

AndExpr : AndExpr '&&' RelExpr
		| RelExpr
		;

RelExpr : AddExpr
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
		| '-' Factor
		| NumberLiteral
		;

NumberLiteral : TINTEGER
			| TREAL
			;


 /* ExprStmt : Expr ';'     {printf("ExprStmt -> Expr;\n");}
		| ';'           {printf("ExprStmt -> ;\n");}
		;

Expr : Expr '+' Term    {printf("Expr -> Expr + Term\n");}
    | Expr '-' Term     {printf("Expr -> Expr - Term\n");}
    | Term              {printf("Expr -> Term\n");}
    ;

Term : Term '*' Factor  {printf("Term -> Term * Factor\n");}
    | Term '/' Factor   {printf("Term -> Term / Factor\n");}
    | Factor            {printf("Term -> Factor \n");}
    ;

Factor : '(' Expr ')'   {printf("Factor -> ( Expr )\n");}
    | TINTEGER          {printf("Factor -> %d\n", $1);}
    | TREAL             {printf("Factor -> %f\n", $1);}
    | TID               {printf("Factor -> %s\n", $1);}
    ;*/

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
