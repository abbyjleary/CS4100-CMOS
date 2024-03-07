default: scanner

scanner: lex.yy.c
	g++ lex.yy.c -o scanner

lex.yy.c: cmos.l
	lex cmos.l

clean:
	rm -f lex.yy.c scanner tokens.txt