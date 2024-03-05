%{

#define TK_INCL 01      // include
#define TK_TYPE 02      // type (int, char, void)
#define TK_COMP 03      // comparison (==, !=, <=, >=, <, >)
#define TK_OP 04        // operator (+, -, *, /, %, &)
#define TK_SEMICOL 05   // semicolon
#define TK_CURLY_BR 06  // curly brace
#define TK_PAREN 07     // parenthesis
#define TK_COMMA 08     // comma
#define TK_RETURN 09    // return
#define TK_LOOP 10      // loop (if, else, while, for, do)
#define TK_VAR 11       // variable
#define TK_STRING 12    // string (in single or double quotes)
#define TK_CHAR 13      // char
#define TK_INCL_PATH 14 // include path
#define TK_UNKNOWN 15   // unknown
#define TK_SPACE 16     // space
#define TK_CMNT 17      // comment
#define TK_ANDOR 18     // || and &&
#define TK_NUM 19       // number
#define TK_ASSIGN 20    // assignment

%}

D [0-9]
L [a-zA-Z]
LD [a-zA-Z0-9]

%%

\/\/.* { return TK_CMNT;}

\/\*(\n|\t|\s|.)*\*\/ { return TK_CMNT;}

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

[ \t\n\f\r] { return TK_SPACE;}

. { return TK_UNKNOWN; }

%%