CFLAGS = -Wall -Werror -O2
CC = gcc
CXX = g++

PROGRAM = cmos 
CCFILES = cmos.cpp

OFILES = ${CCFILES:.cpp=.o}

OBJECTS = lex.yy.o ${OFILES}

cmos : ${OBJECTS}
	${CXX} ${CFLAGS} ${OBJECTS} -o ${PROGRAM}

scanner : lex.yy.o
	${CXX} ${CFLAGS} lex.yy.o -o scanner

lex.yy.c : scanner.l parser.tab.h ${HFILE}
	flex ${LFLAGS} scanner.l
lex.yy.o: lex.yy.c
	${CC} ${CFLAGS} -Wno-unused-function -g -c lex.yy.c

clean:
	rm -f *.o lex.yy.c cmos scanner