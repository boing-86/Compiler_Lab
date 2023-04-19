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
%token<sVal> TID
%token TOPERATOR
%start ExprStmt
%%
 // 문법 쓰기. yylval 도 받아옴!

ExprStmt : Expr ';'     {printf("ExprStmt -> Expr;\n");}

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
    ;

%%

int main(int argc, char *argv[]){
    extern FILE *yyin;
    yyin = fopen(argv[1], "r");
    yyparse();
    fclose(yyin);
}

int yyerror(char *s){
    printf("error");
}