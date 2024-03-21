all: compiler

src/lex.yy.c: src/lexer.l src/grammar.tab.h src/grammar.tab.c
	flex -o src/lex.yy.c src/lexer.l

src/grammar.tab.h: src/grammar.y
	bison src/grammar.y -o src/grammar.tab.c -d

src/grammar.tab.c: src/grammar.y
	bison src/grammar.y -o src/grammar.tab.c

compiler: src/lex.yy.c src/grammar.tab.h src/grammar.tab.c
	gcc -o bin/compiler src/lex.yy.c src/grammar.tab.c -lfl
