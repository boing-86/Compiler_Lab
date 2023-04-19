%{
    #include <stdio.h>
%}

TYPE 

%%
[ \t\n]+    {}
char|int|float|void     {printf("Type ");}
[A-Za-z_][A-Za-z0-9_]*   {printf("ID ");}
0|[1-9][0-9]*           {printf("Integer ");}
"+"|"-"|"*"|"/"|"="     {printf("Operator ");}
.                       {printf("Other ");}
%%