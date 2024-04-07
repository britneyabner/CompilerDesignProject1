all: compiler

src/lex.yy.c: src/lexer.l src/parser.tab.h src/parser.tab.c
	flex -o src/lex.yy.c src/lexer.l

src/parser.tab.h: src/parser.y src/syntax_tree.h
	bison src/parser.y -o src/parser.tab.c -d

src/parser.tab.c: src/parser.y src/syntax_tree.h
	bison src/parser.y -o src/parser.tab.c

compiler: src/lex.yy.c src/parser.tab.h src/parser.tab.c
	gcc -o bin/compiler src/lex.yy.c src/parser.tab.c -lfl
