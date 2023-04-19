%{
    #include "y.tab.h"
%}

WS [ \t\n]+
OPERATOR    [\+\-\*\/]
PAR [\(\)]
INTEGER 0|[1-9][0-9]*


%%

{WS}    {}
{INTEGER}   {return TINTEGER;}
{OPERATOR}  {return yytext[0];}
{PAR}   {return yytext[0];}


%%