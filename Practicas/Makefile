all: calculadora

calculadora: lex.yy.c y.tab.c racional.c
	gcc lex.yy.c y.tab.c racional.c -o calculadora

lex.yy.c: racional.l y.tab.c
	flex racional.l

y.tab.c: gramatica.y
	bison -dy gramatica.y

clean:
	rm -f lex.yy.c y.tab.c y.tab.h calculadora