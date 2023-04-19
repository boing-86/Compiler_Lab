%{
    #include <stdio.h>
%}
LETTER                  [A-Za-z_]
DIGIT                   [0-9]
TYPE                    char|int|float|void
ID                      {LETTER}({LETTER} | {DIGIT})*

%%
[ \t]+    {}
"\n"+                   {printf("\n");}
{TYPE}                  {printf("Type ");}
{ID}                    {printf("ID ");}
0|[1-9][0-9]*           {printf("Integer ");}
"+"|"-"|"*"|"/"|"="     {printf("Operator ");}
.                       {printf("Other ");}
%%