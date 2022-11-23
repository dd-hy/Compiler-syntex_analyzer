all: lex.yy.o test.tab.o
	gcc -o test lex.yy.o test.tab.o

lex.yy.o: test.tab.h lex.yy.c
	gcc -c lex.yy.c

test.tab.o: test.tab.h test.tab.c
	gcc -c test.tab.c

lex.yy.c: test.l
	flex test.l

test.tab.h test.tab.c: test.y
	bison -d test.y

clean:
	rm -rf *.o
	rm -rf test
	rm -rf test.tab.h test.tab.c lex.yy.c
