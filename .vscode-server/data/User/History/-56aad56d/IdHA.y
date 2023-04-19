%{
    #include <stdio.h>
    int yylex(void);
    int yyerror(char*);
%}
%token TINTEGER

%%
 // 문법 쓰
Expr : Expr '+' Term    {printf("Expr -> Expr + Term\n");}
    | Expr '-' Term     {printf("Expr -> Expr - Term\n");}
    | Term              {printf("Expr -> Term\n");}
    ;

Term : Term '*' Factor  {printf("Term -> Term * Factor\n");}
    | Term '/' Factor   {printf("Term -> Term / Factor\n");}
    | Factor            {printf("Term -> Factor \n");}
    ;

Factor : '(' Expr ')'   {printf("Factor -> ( Expr )\n");}
    | TINTEGER          {printf("Factpr -> num\n");}
    ;

%%

int main(void){
    yyparse();
}

int yyerror(char *s){
    printf("error");
}