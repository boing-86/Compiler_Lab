%{
    #include "y.tab.h"
%}

WS [ \t]+
OPERATOR    [\+\-\*\/]
PAR [\(\)]
INTEGER 0|[1-9][0-9]*


%%

\n    {return 0;}
{INTEGER}   {return TINTEGER;}
{OPERATOR}  {return yytext[0];}
{PAR}   {return yytext[0];}


%%