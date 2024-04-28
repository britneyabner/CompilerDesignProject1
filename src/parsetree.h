#ifndef PARSETREE_H
#define PARSETREE_H

#include "symboltable.h"

typedef struct program program_t;
typedef struct declarations declarations_t;
typedef struct type type_t;
typedef struct statement_sequence statement_sequence_t;
typedef struct statement statement_t;
typedef struct assignment assignment_t;
typedef struct if_statement if_statement_t;
typedef struct else_clause else_clause_t;
typedef struct while_statement while_statement_t;
typedef struct write_int write_int_t;
typedef struct expression expression_t;
typedef struct simple_expression simple_expression_t;
typedef struct term term_t;
typedef struct factor factor_t;

typedef enum node_type {
  PROGRAM_NODE,
  DECLARATIONS,
  TYPE,
  STATEMENT_SEQUENCE,
  STATEMENT,
  ASSIGNMENT,
  IF_STATEMENT,
  ELSE_CLAUSE,
  WHILE_STATMENT,
  WRITE_INT,
  EXPRESSION,
  SIMPLE_EXPRESSION,
  TERM,
  FACTOR,
} node_type_t;

struct program {
  node_type_t type;
  declarations_t *declarations_ptr;
  statement_sequence_t *statement_sequence_ptr;
};

// program_t *init_program(declarations_t *d, statement_sequence_t *s);

struct declarations {
  node_type_t node_type;
  char *ident;
  type_t *type_ptr;
  symbol_type_t data_type;
  declarations_t *declarations_ptr;
};

// declarations_t *init_declarations(char *id, type_t *t, declarations_t *d);

struct type {
  node_type_t node_type;
  symbol_type_t data_type;
};

struct statement_sequence {
  node_type_t node_type;
  statement_t *statement_ptr;
  statement_sequence_t *statement_sequence_ptr;
};

struct statement {
  node_type_t node_type;
  assignment_t *assignment_ptr;
  if_statement_t *if_statement_ptr;
  while_statement_t *while_statement_ptr;
  write_int_t *write_int_ptr;
};

struct assignment {
  node_type_t node_type;
  char *ident;
  expression_t *expression_ptr;
};

struct if_statement {
  node_type_t node_type;
  expression_t *expression_ptr;
  statement_sequence_t *statement_sequence_ptr;
  else_clause_t *else_clause_ptr;
};

struct else_clause {
  node_type_t node_type;
  statement_sequence_t *statement_sequence_ptr;
};

struct while_statement {
  node_type_t node_type;
  expression_t *expression_ptr;
  statement_sequence_t *statement_sequence_ptr;
};

struct write_int {
  node_type_t node_type;
  expression_t *expression_ptr;
};

struct expression {
  node_type_t node_type;
  simple_expression_t *simple_expression_one_ptr;
  char *op4;
  simple_expression_t *simple_expression_two_ptr;
};

struct simple_expression {
  node_type_t node_type;
  term_t *term_one_ptr;
  char *op3;
  term_t *term_two_ptr;
};

struct term {
  node_type_t node_type;
  factor_t *factor_one_ptr;
  char *op2;
  factor_t *factor_two_ptr;
};

struct factor {
  node_type_t node_type;
  char *ident;
  int num;
  char *boollit; // can only be "true" or "false"
  expression_t *expression_ptr;
};

typedef union node {
  program_t program;
  declarations_t declarations;
  type_t type;
  statement_sequence_t statement_sequence;
  statement_t statement;
  assignment_t assignment;
  if_statement_t if_statement;
  else_clause_t else_clause;
  while_statement_t while_statement;
  write_int_t write_int;
  expression_t expression;
  simple_expression_t simple_expression;
  term_t term;
  factor_t factor;
} node_t;

int compile(program_t *node);

#endif // PARSETREE_H
