%{

#include <stdio.h>
enum tnumber {TEOF, TTYPE, TID, TCOMMA, TSEMI};

%}

WS [ \t\n]+
TYPE int|float|double|char|void
DIGIT [0-9]
LETTER_ [A-Za-z_]
ID {LETTER_}({LETTER_}|{DIGIT})*

%%

{WS} {}
{TYPE} {return TTYPE;}
{ID} {return TID;}
"," {return TCOMMA;}
";" {return TSEMI;}

%%

int main(int argc, char *argv[]){
    enum tnumber tn;

    if(argc == 1){
        exit(1);
    }

    yyin = fopen(argv[1], "r");

    while((tn = yylex()) != TEOF){
        switch(tn){
        case TTYPE:
            printf("%s %20s %11s\n", yytext,":", "Keyword");
            break;
        case TID:
            printf("%s %20s %11s\n", yytext, ":", "Identifier");
            break;
        case TCOMMA: case TSEMI:
            printf("%s\n\n", yytext);

        default :
            printf("%s\n", yytext);
        }
    }
    return 0;
}