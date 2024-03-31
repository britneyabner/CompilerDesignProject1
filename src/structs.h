#ifndef STRUCTS_H
#define STRUCTS_H

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

struct program {
  declarations_t *declarations_ptr;
  statement_sequence_t *statement_sequence_ptr;
};

struct declarations {
  char *ident;
  type_t *type_struct;
  declarations_t *declarations_ptr;
};

struct type {};

struct statement_sequence {
  statement_t *statement_ptr;
  statement_sequence_t *statement_sequence_ptr;
};

struct statement {
  assignment_t *assignment_ptr;
  if_statement_t *if_statement_ptr;
  while_statement_t *while_statement_ptr;
  write_int_t *write_int_ptr;
};

struct assignment {
  char *ident;
  expression_t *expression_ptr;
};

struct if_statement {
  expression_t *expression_ptr;
  statement_sequence_t *statement_sequence_ptr;
  else_clause_t *else_clause_ptr;
};

struct else_clause {
  statement_sequence_t *statement_sequence_ptr;
};

struct while_statement {
  expression_t *expression_ptr;
  statement_sequence_t *statement_sequence_ptr;
};

struct write_int {
  expression_t *expression_ptr;
};

struct expression {
  simple_expression_t *simple_expression_ptr;
  char *op4; // OP4 can be one or multiple characters
};

struct simple_expression {
  term_t *term_ptr;
  char op3; // OP3 is only ever one character
};

struct term {
  factor_t *factor_ptr;
  int num;
  char *boollit; // BOOLLIT can either be "true" or "false", while it  may be
                 // a bool, the lexeme will be represented as a string.
  expression_t expression_ptr;
};

#endif // STUCTS_H
