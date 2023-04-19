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
%token<ival> TINTEGER
%token<rval> TREAL
%type<rVal> 
%%
 // 문법 쓰기. yylval 도 받아옴!
ExprStmt : Expr         {$$ = $1; printf("Result = %d\n", $$);}
        ;

Expr : Expr '+' Term    {$$ = $1 + $3; printf("Expr -> Expr + Term\n");}
    | Expr '-' Term     {$$ = $1 - $3; printf("Expr -> Expr - Term\n");}
    | Term              {$$ = $1; printf("Expr -> Term\n");}
    ;

Term : Term '*' Factor  {$$ = $1 * $3; printf("Term -> Term * Factor\n");}
    | Term '/' Factor   {$$ = $1 / $3; printf("Term -> Term / Factor\n");}
    | Factor            {$$ = $1; printf("Term -> Factor \n");}
    ;

Factor : '(' Expr ')'   {$$ = $2; printf("Factor -> ( Expr )\n");}
    | TINTEGER          {$$ = $1; printf("Factor -> %d\n", $1);}
    | TREAL             {$$ = $1; printf("Factor -> %f\n", $1);}
    ;

%%

int main(void){
    yyparse();
}

int yyerror(char *s){
    printf("error");
}