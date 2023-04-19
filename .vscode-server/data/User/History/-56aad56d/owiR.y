%{
    #include <stdio.h>
    int yylex(void);
    int yyerror(char*);
%}
%token TINTEGER

%%
 // 문법 쓰
Expr : Expr '+' Term    {}
    | Expr '-' Term     {}
    | Term              {}
    ;

Term : Term '*' Factor
    | Term '/' Factor  
    | Factor
    ;

Factor : '(' Expr ')'
    | TINTEGER
    ;

%%

int main(void){
    yyparse();
}

int yyerror(char *s){
    printf("error");
}