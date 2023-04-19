%{
    #include <stdio.h>
%}
TYPE                    char|int|float|void
ID                      [A-Za-z_][A-Za-z0-9_]*

%%
[ \t]+    {}
"\n                   {printf("\n");}
{TYPE}                  {printf("Type ");}
{ID}                    {printf("ID ");}
0|[1-9][0-9]*           {printf("Integer ");}
"+"|"-"|"*"|"/"|"="     {printf("Operator ");}
.                       {printf("Other ");}
%%