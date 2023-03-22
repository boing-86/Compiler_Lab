token : lex.yy.o
	gcc -o token lex.yy.o -ll

lex.yy.o : lex.yy.c
	gcc -c -o lex.yy.o lex.yy.c

lex.yy.c : tokenizer.l
	flex tokenizer.l

clean:
	rm -f token lex.yy.o lex.yy.c

