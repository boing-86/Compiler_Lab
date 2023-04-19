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
            }
{INTEGER}   {yylval.iVal = atoi(yytext);}
{REAL}      {yylval.rVal = atof(yytext);}
{OPERATOR}  {return yytext[0];}
{PAR}   {return yytext[0];}
;       {return ';';}

%%