%{
#include <stdio.h>

extern int yylex();
extern FILE *yyin;
extern int yylineno;
void yyerror(char *s);
int call = 0;
%}

%token CHAR

%%
seq: seq seq
   | node ',' seq
   | node
   |
   ;
node: CHAR
    ;
%%

void yyerror(char *s) { printf("error %d\n",yylineno); }
int main(int argc, char *argv[]) {
    if (argc > 1)
	yyin = fopen(argv[1],"r");
    yyparse();
    return 0;
}
