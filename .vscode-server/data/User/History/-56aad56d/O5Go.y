%{
    #include <stdio.h>
    int yylex(void);
    int yyerror(char*);
%}
%token TINTEGER

%%

%%