%option noyywrap noinput nounput yylineno
%{
#include "test.tab.h"
%}

NEWLINE		(\\\n|\n)
WHITESPACE	[ \t]+

CHAR		[a-zA-Z0-9_]+

%%

{WHITESPACE}	//
{NEWLINE}	//

{CHAR}		{ return CHAR; }

":"		{ return ':'; }
","		{ return ','; }

.		//

%%
