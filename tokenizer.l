%{
#include <stdio.h>
#include <stdlib.h>

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
DIGIT [0-9]
PUNCTUATION [\(\)\{\}\[\]\:\;]
AOPERATOR [\+|\-|\*|\/|\%|\+\=|\-\=|\*\=|\/\=|\%\=|\+\+|\-\-]
BOPERATOR [\!|\=|\<|\>|\=\=|\!\=|\<\=|\>\=|\&\&|\|\||\,]
OPERATOR {AOPERATOR}|{BOPERATOR}
DECIMAL [1-9]{DIGIT}*
OCTAL 0|[0-7]+
HEXA 0[xX]([A-Fa-f]|{DIGIT})+
INTEGER {HEXA}|{DECIMAL}|{OCTAL}|0
REAL ({DIGIT}*\.{DIGIT}+F?)

CHAR_E '\\[abfnrtv0\\\']'
CHAR_S '[\"\?\+\*\_\-\&\^\%\!\#\(\)\[\]\{\}\;\:\,\.\<\>\/\\]'
CHAR '([a-zA-Z0-9])'|{CHAR_E}|{CHAR_S}
LETTER_ [A-Za-z_]
IDENTIFIER {LETTER_}({LETTER_}|{DIGIT})*
 //(\d+\.\d*F?)|(\.\d+F?)|(\d+\.[eE][+-]?\d+F?)|(\d+\.\d*[eE][+-]?\d*F?)|(\.\d*[eE][+-]?\d*F?)
 // STRING
 // COMMENT



%%
{WS} {}
{KEYWORD} {return TKEYWORD;}
{PUNCTUATION} {return TPUNCTUATION;}
{OPERATOR} {return TOPERATOR;}
{INTEGER} {return TINTEGER;}
{REAL} {return TREAL;}
{CHAR} {return TINTEGER;}
{IDENTIFIER} {return TIDENTIFIER;}

%%

void checkInteger();
void checkReal();

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

            case TREAL :
                checkReal();
                printf("%-15s:%19s,%5.2f\n", yytext, tokenType[3], yylval.rVal );

			default:
				printf("Error occured\n");
		}
		
	}

	fclose(yyin);
	return 0;
}


void checkInteger(){

    if (yytext[1] == 'x' || yytext[1] == 'X'){
        yylval.iVal = strtol(yytext, NULL, 16);
    }

    else if(yytext[0] == '\''){
        yylval.iVal = yytext[1];

        if(yyleng == 4){
            char a;
            switch(yytext[2]){

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
                
            }
            yylval.iVal = a;
        }
    }

    else if(yytext[0] != '0'){
        yylval.iVal = strtol(yytext, NULL, 10);
    }

    else if(yytext[0] == 48){
        yylval.iVal = strtol(yytext, NULL, 8);
    }
}

void checkReal(){
    yylval.rVal = strtof(yytext, NULL);
}

// Define additional functions here if you need...


// 2. 토큰이 실수 상수일 때
// token 값을 yylval.rval 에 넣고 출력
// printf("%-15s:%19s,%5.2f\n", yytext, tokenType[3], yylval.rVal );

// 3. 토큰이 문자열일 때: 
// malloc 함수를 이용하여 메모리 공간을 만든 후
// "" 을 제거한 내용을 메모리 공간에 복사
// yylval.sVal 에 공간의 주소를 넣고 출력
	// yylval.sVal = (char*)malloc(yyleng+1);
	// strcpy(yylval.sVal, yytext);
// printf("%-15s:%19s,%s\n", yytext, tokenType[4], yylval.sVal );

// 4. 이외 토큰
// printf("%-15s:%19s\n", yytext, tokenType[다른 숫자]);

// 5. 에러
// printf("Error occured!\n");