default: scanner cmos

scanner: lex.yy.c
	g++ lex.yy.c -o scanner

lex.yy.c: cmos.l
	lex cmos.l

cmos: cmos.cpp
	g++ cmos.cpp -o cmos

clean:
	rm -f lex.yy.c scanner tokens.txt scanner_out.txt a.out