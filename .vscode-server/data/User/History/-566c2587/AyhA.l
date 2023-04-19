%{
    #include <stdlib.h>
    #include "y.tab.h"
%}

WS [ \t]+
OPERATOR    [\+\-\*\/]
PAR [\(\)]
INTEGER 0|[1-9][0-9]*
REAL [0-9]+.[0-9]+

%%

\n    {return 0;}
{INTEGER}   {yylval.iVal = atoi(yytext); return TINTEGER;}
{REAL}      {yylval.rVal = atof(yytext);}
{OPERATOR}  {return yytext[0];}
{PAR}   {return yytext[0];}


%%