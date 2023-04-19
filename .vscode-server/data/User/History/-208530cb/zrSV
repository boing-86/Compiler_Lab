parser : y.tab.o lex.yy.o
	gcc -o parser y.tab.o lex.yy.o -ll

lex.yy.o : lex.yy.c
	gcc -c -o lex.yy.o lex.yy.c

y.tab.o : y.tab.c y.tab.h
	gcc -c -o y.tab.o y.tab.c

lex.yy.c : tokenizer.l
	flex tokenizer.l

y.tab.c : parser.y
	yacc -d parser.y

clean :
	rm -f y.tab.c y.tab.h lex.yy.c lex.yy.o y.tab.o parser
