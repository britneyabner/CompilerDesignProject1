a.out: lex.yy.c
	gcc -o a.out lex.yy.c -lfl

lex.yy.c: src/lexical_analyzer.l
	flex src/lexical_analyzer.l
