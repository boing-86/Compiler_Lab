%{
    #include <stdlib.h>
    #include "y.tab.h"
%}

WS [ \n\t]+
OPERATOR    [\+\-\*\/]
PAR [\(\)]
INTEGER 0|[1-9][0-9]*
REAL [0-9]+\.[0-9]+
ID [A-Za-z_][A-Za-z0-9_]*

%%

\n    {printf("공백\n"); return 0;}
{ID}        {printf("%s", yytext); yylval.sVal = malloc(strlen(yytext)+1); 
                strcpy(yylval.sVal, yytext); 
                return TID;}
{INTEGER}   {printf("%s", yytext); yylval.iVal = atoi(yytext); return TINTEGER;}
{REAL}      {printf("%s", yytext); yylval.rVal = atof(yytext); return TREAL;}
{OPERATOR}  {return yytext[0];}
{PAR}   {return yytext[0];}
;       {return ';';}

%%