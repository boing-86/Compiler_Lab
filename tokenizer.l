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

%%

 // 각종 액션들...

%%

int main(int argc, char *argv[]){
	enum tnumber tn;
	if(!argc)	exit(0);
	yyin = fopen(argv[1], "r");

	while((tn == yylex() != TEOF)){
		
	}

// Insert source code here... 
// 아마도 switch - case 문 위주...
	// malloc 예시
	// yylval.sVal = (char*)malloc(yyleng+1);
	// strcpy(yylval.sVal, yytext);

	fclose(yyin);
	return 0;
}

// Define additional functions here if you need...
