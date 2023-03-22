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

KEYWORD break|case|char|default|do|else|float|for|if|int|return|switch|void|while
PUNCTUATION [\(\)\{\}\[\]\:\;]
OPERATOR [\+|\-|\*|\/|\=]
 // Operator 추가 필요
DIGIT [0-9]
DECIMAL [1-9]{DIGIT}*
OCTAL 0|[0-7]+
HEXA 0[xX]([A-Fa-f]|{DIGIT})+
LETTER_ [A-Za-z_]
IDENTIFIER {LETTER_}({LETTER_}|{DIGIT})*
INTEGER {HEXA}|{DECIMAL}|{OCTAL}|0
REAL
STRING
COMMENT


%%

{KEYWORD} {return TKEYWORD;}
{PUNCTUATION} {return TPUNCTUATION;}
{OPERATOR} {return TOPERATOR;}
{IDENTIFIER} {return TIDENTIFIER;}
{INTEGER} {return TINTEGER;}

%%

int main(int argc, char *argv[]){
	enum tnumber tn;
	if(!argc)	exit(0);
	yyin = fopen(argv[1], "r");
// TEOF, TKEYWORD, TIDENTIFIER, TINTEGER, TREAL, TSTRING, TCOMMENT
// TOPERATOR, TPUNCTUATION, TERROR
	while((tn == yylex() != TEOF)){
		switch(tn){
			case TKEYWORD :
				printf("%-15s:%19s\n", yytext, tokenType[0]);
				break;

			// case TIDENTIFIER :
			// case TINTEGER :
			// case TREAL :
			// case TSTRING :
			// case TCOMMENT :
			// case TOPERATOR :
			// case TPUNCTUATION :
			// case TERROR :

			default:
				printf("Error occured\n");
		}
		
	}

	fclose(yyin);
	return 0;
}

// Define additional functions here if you need...

// 1. 토큰이 정수 상수, 문자 상수일 때
// token 값을 yylval.iVal 에 입력, 및 출력
// printf("%-15s:%19s,%5d\n", yytext, tokenType[2], yylval.iVal);

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