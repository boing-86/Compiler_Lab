%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

char* tokenType[] = {"Keyword", "Identifier", "Integer", "Real", "String", "Comment", "Operator", "Punctuation"};

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
    char|default|do|else|float|for|if|int|return|switch|void|while
    if (strcmp(yytext, "break")==0){
        return TBREAK;
    }

    else if (strcmp(yytext, "case")==0){
        return TCASE;
    }

    else if (strcmp(yytext, "char")==0){
        return TCHAR;
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