%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* tokenType[] = {"Keyword", "Identifier", "Integer", "Real", "String", "Comment", "Operator", "Punctuation"};
enum tnumber {TEOF, TKEYWORD, TIDENTIFIER, TINTEGER, TREAL, TSTRING, TCOMMENT, TOPERATOR, TPUNCTUATION, TERROR};
// Declare additional variables or functions here if you need...

union{
	int iVal;
	float rVal;
	char* sVal;
} yylval;

%}

 // 각종 정의
WS [ \t\n]+
KEYWORD break|case|char|default|do|else|float|for|if|int|return|switch|void|while
IDENTIFIER [A-Za-z_][A-Za-z0-9_]*
DIGIT [0-9]
INTEGER [1-9][0-9]*|0|0[0-7]+|0[xX][A-Fa-f0-9]+
PUNCTUATION [\(\)\{\}\[\]\:\;]
REAL ({DIGIT}*\.{DIGIT}+F+)|({DIGIT}+\.{DIGIT}*[fF])|(\.{DIGIT}+[fF])|({DIGIT}+\.[eE][+-]?{DIGIT}+[fF])|({DIGIT}+\.{DIGIT}*[eE][+-]?{DIGIT}*[fF])|(\.{DIGIT}*[eE][+-]?{DIGIT}*[fF])
COMMENT_LINE \/\/[^\n]*\n
COMMENT_LINES \/\*([^\*]|\*+[^\*\/])*\*+\/
COMMENT {COMMENT_LINE}|{COMMENT_LINES}
ESCAPE \\[abfnrtv0\'\"\?\\]
STRING \"([^\\\'\"\n]|{ESCAPE})*\"
CHAR_E '{ESCAPE}'
CHAR_S '[\+\*\_\-\&\^\%\!\#\(\)\[\]\{\}\;\:\,\.\<\>\/\|\~\=]'
CHAR '([a-zA-Z0-9])'|{CHAR_E}|{CHAR_S}
AOPERATOR [\+|\-|\*|\/|\%]
BOPERATOR [\!|\=|\<|\>]
OPERATOR {AOPERATOR}|{AOPERATOR}(=)|\+\+|\-\-|{BOPERATOR}|{BOPERATOR}(=)|\|\||\&\&|,
%%

{WS} {}
{KEYWORD} {
    if (strcmp(yytext, "break")==0){
        printf("###### break #####");
    }
    return TKEYWORD;}
{IDENTIFIER} {return TIDENTIFIER;}
{PUNCTUATION} {return TPUNCTUATION;}
{INTEGER} {return TINTEGER;}
{STRING} {return TSTRING;}
{REAL} {return TREAL;}
{COMMENT} {return TCOMMENT;}
{CHAR} {return TINTEGER;}
{OPERATOR} {return TOPERATOR;}
. {return TERROR;}
%%

void checkInteger();
void checkString();
char checkEscape(const char ch);

int main(int argc, char *argv[]){
	enum tnumber tn;
	if(argc == 1){
        exit(1);
    }

    yyin = fopen(argv[1], "r");

// TEOF, TKEYWORD, TIDENTIFIER, TINTEGER, TREAL, TSTRING, TCOMMENT
// TOPERATOR, TPUNCTUATION, TERROR
	while((tn = yylex()) != TEOF){
		switch(tn){

			case TKEYWORD:
                printf("%-15s:%19s\n", yytext, tokenType[0]);
                break;

            case TIDENTIFIER:
                printf("%-15s:%19s\n", yytext, tokenType[1]);
                break;

            case TINTEGER:
                checkInteger();
                printf("%-15s:%19s,%5d\n", yytext, tokenType[2], yylval.iVal);
                break;

            case TREAL :
                yylval.rVal = strtof(yytext, NULL);
                printf("%-15s:%19s,%5.2f\n", yytext, tokenType[3], yylval.rVal);
                break;

            case TSTRING :
                yylval.sVal = (char*)malloc(yyleng);
                checkString();
                printf("%-15s:%19s,%s\n", yytext, tokenType[4], yylval.sVal);
                break;

            case TCOMMENT :
                printf("%-15s:%19s\n", yytext, tokenType[5]);
                break;

            case TOPERATOR :
                printf("%-15s:%19s\n", yytext, tokenType[6]);
                break;

            case TPUNCTUATION :
                printf("%-15s:%19s\n", yytext, tokenType[7]);
                break;

			default:
				printf("Error occured\n");
                return 0;
		}
		
	}

	fclose(yyin);
	return 0;
}

char checkEscape(const char ch){
    char a ;
    switch(ch){
        case '\'':
            a = '\'';
            break;

        case '\"':
            a = '\"';
            break;
        
        case '\?':
            a = '\?';
            break;

        case '\\':
            a = '\\';
            break;

        case 'a':
            a = '\a';
            break;

        case 'b':
            a = '\b';
            break;
        
        case 'f':
            a = '\f';
            break;

        case 'n':
            a = '\n';
            break;

        case 'r':
            a = '\r';
            break;

        case 't':
            a = '\t';
            break;

        case 'v':
            a = '\v';
            break;

        case '0':
            a = '\0';
            break;

        default :
            return ch;
        /// git test
    }
    return a;
}

void checkInteger(){

    if (yytext[1] == 'x' || yytext[1] == 'X'){
        if(yytext[0] == '0'){
            yylval.iVal = strtol(yytext, NULL, 16);
        }
        else{
            yylval.iVal = yytext[1];
        }
    }

    else if(yytext[0] == '\''){
        yylval.iVal = yytext[1];

        if(yyleng == 4){
            yylval.iVal = checkEscape(yytext[2]);
        }
    }

    else if(yytext[0] != '0'){
        yylval.iVal = strtol(yytext, NULL, 10);
    }

    else if(yytext[0] == 48){
        yylval.iVal = strtol(yytext, NULL, 8);
    }
}

void checkString(){
    char* yystring;
    yystring = (char*)malloc(yyleng);
    strncpy(yystring, &yytext[1], yyleng-2);
    char* ptr = strtok(yystring, "\\");
    while(ptr != NULL){
        char a = ptr[0];
        ptr[0] = checkEscape(a);
        strcat(yylval.sVal, ptr);
        ptr = strtok(NULL, "\\");
    }
	
}