%{
/*
* CS 4100
* CMOS
* 3/8/2024
* Abby Leary and Adeline Fitzwater
*/

#define TK_INCL 1       // include
#define TK_TYPE 2       // type (int, char, void)
#define TK_COMP 3       // comparison (==, !=, <=, >=, <, >)
#define TK_OP 4         // operator (+, -, *, /, %, &)
#define TK_SEMICOL 5    // semicolon
#define TK_CURLY_BR 6   // curly brace
#define TK_PAREN 7      // parenthesis
#define TK_COMMA 8      // comma
#define TK_RETURN 9     // return
#define TK_LOOP 10      // loop (if, else, while, for, do)
#define TK_VAR 11       // variable
#define TK_STRING 12    // string (in single or double quotes)
#define TK_CHAR 13      // char
#define TK_INCL_PATH 14 // include path
#define TK_ANDOR 15     // || and &&
#define TK_NUM 16       // number
#define TK_ASSIGN 17    // assignment

#include <iostream>
#include <iomanip>
#include <fstream>

%}

D [0-9]
L [a-zA-Z]
LD [a-zA-Z0-9]

%%

\/\/.* { }

"/*"([^*]|\*+[^*/])*\*+"/" { }

\#include { return TK_INCL; }

\<{L}+\.{L}+\> { return TK_INCL_PATH;}

int|char|void { return TK_TYPE; }

!=|==|<=|>=|<|> { return TK_COMP; }

\+|\-|\*|\/|\%|\& { return TK_OP; }

\; { return TK_SEMICOL; }

\{|\} { return TK_CURLY_BR; }

\(|\) { return TK_PAREN; }

\, { return TK_COMMA; }

return(\({LD}*\))? { return TK_RETURN; }

if|else|while|for|do { return TK_LOOP; }

\|\||\&\& { return TK_ANDOR; }

({L}({LD}|\_)*) { return TK_VAR; }

{D} { return TK_NUM; }

\'{LD}\' { return TK_CHAR; }

\".*\"|\'.*\' { return TK_STRING; }

= { return TK_ASSIGN; }

[ \t\n\f\r] { }

%%

int yywrap(){
    return 1;
}

int main(){
    int token;
    std::ofstream out("scanner_out.txt");
    while((token = yylex())){
        out << std::setw(2) << std::setfill('0') << token;
    }
    return 0;
}