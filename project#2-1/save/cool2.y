/*
 * Copyright 2020-2022. Heekuck Oh, all rights reserved
 * 이 프로그램은 한양대학교 ERICA 소프트웨어학부 재학생을 위한 교육용으로 제작되었다.
 */
%{
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include "node.h"

int yylex();
extern FILE* yyin;
extern int yylineno;
extern char *yytext;
static int num_errors = 0;
static class_list_t *program;
void yyerror(char const *s);
%}

%union{
    class_list_t *class_list;
    char *s;
    int i;
    bool b;
}

%token CLASS INHERITS IF THEN ELSE FI LET IN
%token WHILE LOOP POOL CASE OF DARROW ESAC
%token NEW ISVOID ASSIGN NOT LTE
%token <s> STRING TYPE ID
%token <i> INTEGER
%token <b> BOOLEAN

%type <class_list> class_list

%start program

%%

program: class_list { program = $1; }
       ;
class_list: class_list class ';' { $$ = (class_list_t *)malloc(sizeof(class_list_t)); $$->next = $1; $$->class = $2; }
	  | class_list error ';' { $$ = (class_list_t *)malloc(sizeof(class_list_t)); $$->next = $1; $$->class = NULL; }
	  | { $$ = NULL; }
	  ;
class: CLASS TYPE INHERITS TYPE '{' feature_list '}' { $$ = (class_t *)malloc(sizeof(class_t)); $$->type = $2; $$->inherited = $4; $$->feature_list = $6; }
     | CLASS TYPE '{' feature_list '}' { $$ = (class_t *)malloc(sizeof(class_t)); $$->type = $2; $$->inherited = NULL; $$->feature_list = $4; }
     ;
feature_list: feature_list feature ';' { $$ = (feature_list_t *)malloc(sizeof(feature_list_t)); $$->next = $1; $$->feature = $2; }
	    | feature_list error ';' { $$ = (feature_list_t *)malloc(sizeof(feature_list_t)); $$->next = $1; $$->feature = NULL; }
	    | { $$ = NULL; }
	    ;
feature: ID '(' formal_seq ')' ':' TYPE '{' expr '}' { $$ = (feature_t *)malloc(sizeof(feature_t)); $$->id = $1; $$->formal_list = $3; $$->type = $6; $$->expr = $8; }
       | ID '(' ')' ':' TYPE '{' expr '}' { $$ = (feature_t *)malloc(sizeof(feature_t)); $$->id = $1; $$->formal_list = NULL; $$->type = $5; $$->expr = $7; }
       | feature_ { $$ = $1; }
       ;
feature__seq: feature__seq ',' feature_ { feature__seq = $1; $1->next = $3; }
	    | feature_
	    | error
	    ;
feature_: formal ASSIGN expr
	| formal
	;
formal_seq: formal_seq ',' formal
	  | formal
	  ;
formal: ID ':' TYPE { }
      ;
expr_list: expr_list expr ';'
	 | expr_list error ';'
	 |
	 ;
expr_seq: expr_seq ',' expr
	| expr
	;
expr: ID ASSIGN expr
    | expr '@' TYPE '.' ID '(' expr_seq ')'
    | expr '@' TYPE '.' ID '(' ')'
    | expr '.' ID '(' expr_seq ')'
    | expr '.' ID '(' ')'
    | ID '(' expr_seq ')'
    | ID '(' ')'
    | IF expr THEN expr ELSE expr FI
    | WHILE expr LOOP expr POOL
    | '{' expr_list '}'
    | LET feature__seq IN expr
    | CASE expr OF case ';' case_list ESAC
    | NEW TYPE
    | ISVOID expr
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | '~' expr
    | expr '<' expr
    | expr LTE expr
    | expr '=' expr
    | NOT expr
    | '(' expr ')'
    | ID
    | INTEGER
    | STRING
    | BOOLEAN
    ;
case_list: case_list case ';'
	 |
	 ;
case: formal DARROW expr
    ;

%%

void yyerror(char const *s)
{
    /*
     * 오류의 개수를 누적한다.
     */
    ++num_errors;
    /*
     * 문법 오류가 발생한 줄번호와 관련된 토큰을 출력한다.
     */
    if (yychar > 0)
        printf("%s in line %d at \"%s\"\n", s, yylineno, yytext);
    else
        printf("%s in line %d (unexpected EOF)\n", s, yylineno);
}

int main(int argc, char *argv[])
{
    /*
     * 스캔할 COOL 파일을 연다. 파일명이 없으면 표준입력이 사용된다.
     */
    if (argc > 1)
        if (!(yyin = fopen(argv[1],"r"))) {
            printf("\"%s\"는 잘못된 파일 경로입니다.\n", argv[1]);
            exit(1);
        }
    /*
     * 구문분석을 위해 수행한다.
     */
    yyparse();
    /*
     * 오류의 개수를 출력한다.
     */
    if (num_errors > 0)
         printf("%d error(s) found\n", num_errors);
    else
         show_class_list(program);
    
    return 0;
}
