%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
int yyerror(const char *);
%}

%code requires
{
    #include "syntax_tree.h"
}

%union
{
    char *sval;
    int ival;
    program_t *program_val;
    declarations_t *declarations_val;
    type_t  *type_val;
    statement_sequence_t *statement_sequence_val;
    statement_t *statement_val;
    assignment_t *assigment_val;
    if_statement_t *if_statement_val;
    else_clause_t *else_clause_val;
    while_statement_t *while_statement_val;
    write_int_t *write_int_val;
    expression_t *expression_val;
    simple_expression_t *simple_expression_val;
    term_t *term_val;
    factor_t *factor_val;
}

%token <ival> NUM
%token <sval> BOOLLIT
%token <sval> IDENT
%token LP
%token RP
%token ASGN
%token SC
%token <sval> OP2
%token <sval> OP3
%token <sval> OP4
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

%type <program_val> program
%type <declarations_val> declarations
%type <type_val> type
%type <statement_sequence_val> statement_sequence
%type <statement_val> statement
%type <assigment_val> assignment
%type <if_statement_val> if_statement
%type <else_clause_val> else_clause
%type <while_statement_val> while_statement
%type <write_int_val> write_int
%type <expression_val> expression
%type <simple_expression_val> simple_expression
%type <term_val> term
%type <factor_val> factor

%start program

%%

program:
    PROGRAM declarations BEGIN_T statement_sequence END
        {
            $$ = malloc(sizeof(program_t));
            $$->declarations_ptr = $2;
            $$->statement_sequence_ptr = $4;
            
        }
    ;

declarations: 
    /* empty */ { $$ = NULL; }
    | VAR IDENT AS type SC declarations
        {
            $$ = malloc(sizeof(declarations_t));
            $$->ident = $2;
            $$->type_ptr = $4;
            $$->declarations_ptr = $6;
        }
    ;

type:
    INT
        {
            $$ = malloc(sizeof(type_t));
        }
    | BOOL
        {
            $$ = malloc(sizeof(type_t));
        }
    ;

statement_sequence:
    /* empty */ { $$ = NULL; }
    | statement SC statement_sequence
        {
            $$ = malloc(sizeof(statement_sequence_t));
            $$->statement_ptr = $1;
            $$->statement_sequence_ptr = $3;
        }
    ;

statement:
    assignment
        {
            $$ = malloc(sizeof(statement_t));
            $$->assignment_ptr = $1;
        }
    | if_statement
        {
            $$ = malloc(sizeof(statement_t));
            $$->if_statement_ptr = $1;
        }
    | while_statement
        {
            $$ = malloc(sizeof(statement_t));
            $$->while_statement_ptr = $1;
        }
    | write_int
        {
            $$ = malloc(sizeof(statement_t));
            $$->write_int_ptr = $1;
        }
    ;

assignment:
    IDENT ASGN expression
        {
            $$ = malloc(sizeof(assignment_t));
            $$->ident = $1;
            $$->expression_ptr = $3;
        }
    | IDENT ASGN READINT
        {
            $$ = malloc(sizeof(assignment_t));
            $$->ident = $1;
        }
    ;

if_statement:
    IF expression THEN statement_sequence else_clause END
        {
            $$ = malloc(sizeof(if_statement_t));
            $$->expression_ptr = $2;
            $$->statement_sequence_ptr = $4;
            $$->else_clause_ptr = $5;
        }
    ;

else_clause:
    /* empty */ { $$ = NULL; }
    | ELSE statement_sequence
        {
            $$ = malloc(sizeof(else_clause_t));
            $$->statement_sequence_ptr = $2;
        }
    ;

while_statement:
    WHILE expression DO statement_sequence END
    {
        $$ = malloc(sizeof(while_statement_t));
        $$->expression_ptr = $2;
        $$->statement_sequence_ptr = $4;
    }
    ;

write_int:
    WRITEINT expression
    {
        $$ = malloc(sizeof(expression_t));
        $$->expression_ptr = $2;
    }
    ;

expression:
    simple_expression
    {
        $$ = malloc(sizeof(simple_expression_t));
        $$->simple_expression_one_ptr = $1;
    }
    | simple_expression OP4 simple_expression
    {
        $$ = malloc(sizeof(simple_expression_t));
        $$->simple_expression_one_ptr = $1;
        $$->op4 = $2;
        $$->simple_expression_two_ptr = $3;
    }
    ;

simple_expression:
    term OP3 term
    {
        $$ = malloc(sizeof(simple_expression_t));
        $$->term_one_ptr = $1;
        $$->op3 = $2;
        $$->term_two_ptr = $3;
    }
    | term
    {
        $$ = malloc(sizeof(simple_expression_t));
        $$->term_one_ptr = $1;
    }
    ;

term:
    factor OP2 factor
    {
        $$ = malloc(sizeof(term_t));
        $$->factor_one_ptr = $1;
        $$->op2 = $2;
        $$->factor_two_ptr = $3;
    }
    | factor
    {
        $$ = malloc(sizeof(term_t));
        $$->factor_one_ptr = $1;
    }
    ;

factor:
    IDENT 
    {
        $$ = malloc(sizeof(factor_t));
        $$->ident = $1;
    }
    | NUM
    {
        $$ = malloc(sizeof(factor_t));
        $$->num = $1;
    }
    | BOOLLIT
    {
        $$ = malloc(sizeof(factor_t));
        $$->boollit = $1;
    }
    | LP expression RP
    {
        $$ = malloc(sizeof(factor_t));
        $$->expression_ptr = $2;
    }
    ;
%%


int yyerror(const char *s) {
    printf("yyerror : %s\n", s);
    exit(1);
}

int main() {
    yyparse();
    return 0;
}

int yywrap() {}
