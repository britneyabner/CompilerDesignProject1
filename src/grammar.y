%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyerror(char *);
%}

%token NUM
%token BOOLLIT
%token IDENT
%token LP
%token RP
%token ASGN
%token SC
%token OP2
%token OP3
%token OP4
%token IF
%token THEN
%token ELSE
%token BEGIN_T
%token END
%token WHILE
%token DO
%token PROGRAM
%token VAR
%token AS
%token INT
%token BOOL
%token WRITEINT
%token READINT

%start program

%%

program:
    PROGRAM declarations BEGIN_T statement_sequence END
    ;

declarations: 
    VAR IDENT AS type SC declarations
    | /* empty */
    ;

type:
    INT
    | BOOL
    ;

statement_sequence:
    statement SC statement_sequence
    | /* empty */
    ;

statement:
    assignment
    | if_statement
    | while_statement
    | write_int
    ;

assignment:
    IDENT ASGN simple_expression
    | IDENT ASGN READINT
    ;

if_statement:
    IF expression THEN statement_sequence else_clause END
    ;

else_clause:
    ELSE statement_sequence
    | /* empty */
    ;

while_statement:
    WHILE expression DO statement_sequence END
    ;

write_int:
    WRITEINT expression
    ;

expression:
    simple_expression
    | simple_expression OP4 simple_expression
    ;

simple_expression:
    term OP3 term
    | term
    ;

term:
    factor OP2 factor
    | factor
    ;

factor:
    IDENT
    | NUM
    | BOOLLIT
    | LP expression RP
    ;
%%


int yyerror(char *s) {
    printf("yyerror : %s\n", s);
    exit(1);
}

int main() {
    yyparse();
    printf("SUCCESS\n");
    return 0;
}

int yywrap() {

}
