%{
    #include <stdio.h>
%}
LETTER                  [A-Za-z_]
DIGIT                   [0-9]
INTEGER                 0|[1-9]{DIGIT}*
TYPE                    char|int|float|void
ID                      {LETTER}({LETTER} | {DIGIT})*

%%
[ \t]+    {}
"\n"+                   {printf("\n");}
{TYPE}                  {printf("Type ");}
{ID}                    {printf("ID ");}
{INTEGER}               {printf("Integer ");}
"+"|"-"|"*"|"/"|"="     {printf("Operator ");}
.                       {printf("Other ");}
%%