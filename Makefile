all: compiler

src/lex.yy.c: src/lexer.l src/parser.tab.h src/parser.tab.c src/symboltable.h src/symboltable.c
	flex -o src/lex.yy.c src/lexer.l

src/parser.tab.h: src/parser.y src/parsetree.h
	bison src/parser.y -o src/parser.tab.c -d

src/parser.tab.c: src/parser.y src/parsetree.h
	bison src/parser.y -o src/parser.tab.c

compiler: src/lex.yy.c src/parser.tab.h src/parser.tab.c src/parsetree.h
	gcc -o bin/compiler src/lex.yy.c src/parser.tab.c src/parsetree.c src/symboltable.c -lfl
