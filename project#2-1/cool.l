/*
 * Copyright 2020-2022. Heekuck Oh, all rights reserved
 * 이 프로그램은 한양대학교 ERICA 소프트웨어학부 재학생을 위한 교육용으로 제작되었다.
 */
%option noinput nounput yylineno
%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "node.h"
#include "cool.tab.h"
%}

NEWLINE     (\r\n|\n)
WHITESPACE  [ \t]+
DASHCOMMENT --.*\n

COMMENT	    "(*".*"*)"

BOOLEAN	    (?i:true)|(?i:false)
INTEGER	    [0-9]+
STRING	    \"[^\n"]+\"

ID	    [a-z][a-zA-Z0-9_]*
TYPE	    [A-Z][a-zA-Z0-9_]*

%%
                
{WHITESPACE}    /* skip */
{NEWLINE}       /* skip */
{DASHCOMMENT}   /* skip */

{COMMENT}

{BOOLEAN}	     { return BOOLEAN; }
{INTEGER}	     { return INTEGER; }
{STRING}	     { return STRING; }

(?i:class)           { return CLASS; }
(?i:inherits)        { return INHERITS; }

(?i:if)		     { return IF; }
(?i:then)	     { return THEN; }
(?i:else)	     { return ELSE; }
(?i:fi)		     { return FI; }
(?i:let)	     { return LET; }
(?i:in)		     { return IN; }
(?i:while)	     { return WHILE; }
(?i:loop)	     { return LOOP; }
(?i:pool)	     { return POOL; }
(?i:case)	     { return CASE; }
(?i:of)		     { return OF; }
(?i:esac)	     { return ESAC; }
(?i:new)	     { return NEW; }
(?i:isvoid)	     { return ISVOID; }
(?i:not)	     { return NOT; }

{ID}		     { return ID; }
{TYPE}		     { return TYPE; }

"("     { return '('; }
")"     { return ')'; }
"{"     { return '{'; }
"}"     { return '}'; }
"<="    { return LTE; }
"<-"    { return ASSIGN; }
"<"     { return '<'; }
"=>"    { return DARROW; }
"="     { return '='; }
","     { return ','; }
";"     { return ';'; }
":"     { return ':'; }
"."     { return '.'; }
"+"     { return '+'; }
"-"     { return '-'; }
"*"     { return '*'; }
"/"     { return '/'; }
"~"     { return '~'; }
"@"     { return '@'; }
.       { fprintf(stderr, "Skip unknown character %s in line %d\n", yytext, yylineno); }

%%

