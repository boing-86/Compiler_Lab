%{
    #include <stdlib.h>
    #include "y.tab.h"
%}

WS [ \t]+
OPERATOR    [\+\-\*\/]
PAR [\(\)]
INTEGER 0|[1-9][0-9]*
REAL [0-9]+\.[0-9]+
ID [A-Za-z_][A-Za-z0-9_]*

%%

\n    {return 0;}
{ID}        {yylval.sVal = malloc(strlen(yytext)+1); 
                strcpy(yylval.sVal, yytext); 
                return TID;}
{INTEGER}   {yylval.iVal = atoi(yytext); return TINTEGER;}
{REAL}      {yylval.rVal = atof(yytext); return TREAL}
{OPERATOR}  {return yytext[0];}
{PAR}   {return yytext[0];}
;       {return ';';}

%%