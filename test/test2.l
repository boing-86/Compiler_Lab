%{

#include <stdio.h>
#include <stdlib.h>
enum tnumber {TEOF, TKEYWORD, TIDENTIFIER, TINTEGER, TREAL, TSTRING, TCOMMENT, TOPERATOR, TPUNCTUATION, TERROR};
char* tokenType[] = {"Keyword", "Identifier", "Integer", "Real", "String", "Comment", "Operator", "Punctuation"};

union{
	int iVal;
	float rVal;
	char* sVal;
} yylval;


%}

WS [ \t\n]+
KEYWORD break|case|char|default|do|else|float|for|if|int|return|switch|void|while
DIGIT [0-9]
PUNCTUATION [\(\)\{\}\[\]\:\;]
OPERATOR [\+|\-|\*|\/|\=]
LETTER_ [A-Za-z_]
DECIMAL [1-9]{DIGIT}*
OCTAL 0|[0-7]+
HEXA 0[xX]([A-Fa-f]|{DIGIT})+
INTEGER {HEXA}|{DECIMAL}|{OCTAL}|0
IDENTIFIER {LETTER_}({LETTER_}|{DIGIT})*

%%

{WS} {}
{KEYWORD} {return TKEYWORD;}
{PUNCTUATION} {return TPUNCTUATION;}
{OPERATOR} {return TOPERATOR;}
{IDENTIFIER} {return TIDENTIFIER;}
{INTEGER} {return TINTEGER;}



%%

void checkInteger();

int main(int argc, char *argv[]){
    enum tnumber tn;
    int dec;

    if(argc == 1){
        exit(1);
    }

    yyin = fopen(argv[1], "r");

    while((tn = yylex()) != TEOF){
        switch(tn){
            case TKEYWORD:
                printf("%-15s:%19s\n", yytext, tokenType[0]);
                break;

            case TPUNCTUATION :
                printf("%-15s:%19s\n", yytext, tokenType[7]);
                break;

            case TOPERATOR :
                printf("%-15s:%19s\n", yytext, tokenType[6]);
                break;

            case TIDENTIFIER:
                printf("%-15s:%19s\n", yytext, tokenType[1]);
                break;

            case TINTEGER:
                
                checkInteger();

                printf("%-15s:%19s,%5d\n", yytext, tokenType[2], yylval.iVal);
                break;

            default :
                printf("%s\n", yytext);
        }
    }
    return 0;
}

void checkInteger(){
    if (yytext[1] == 'x' || yytext[1] == 'X'){
        yylval.iVal = strtol(yytext, NULL, 16);
    }

    else if(yytext[0] != '0'){
        yylval.iVal = strtol(yytext, NULL, 10);
    }

    else if(yytext[0] == 48){
        yylval.iVal = yylval.iVal = strtol(yytext, NULL, 8);
    }
}