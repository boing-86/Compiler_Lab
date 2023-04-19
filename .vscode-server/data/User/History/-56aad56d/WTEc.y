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

%%
 // 문법 쓰기. yylval 도 받아옴!

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
    | TID               {printf("Facotkr -> %s\n", $1);}
    ;

%%

int main(void){
    yyparse();
}

int yyerror(char *s){
    printf("error");
}