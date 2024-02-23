/*
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


typedef enum token {
  num,
  boollit,
  ident,
  LP,
  RP,
  ASGN,
  SC,
  OP2,
  OP3,
  OP4,
  IF,
  THEN,
  ELSE,
  BEGIN,
  END,
  WHILE,
  DO,
  PROGRAM,
  VAR,
  AS,
  INT,
  BOOL,
  WRITEINT,
  READINT,
} token_t;

void invalid_grammar_error();
bool program(token_t *input);
bool declarations(token_t *input);
bool statement_sequence(token_t *input);
bool type(token_t *input);

/*
// <program> ::= PROGRAM <declarations> BEGIN <statement_sequence> END
bool program(token_t *input) {
  for(int i = 0; i < 5; i++) {
    switch(i)
    {
      case 0: // PROGRAM
        if(*input != PROGRAM)
          return 0;
        input++;
        break;
      case 1: // <declarations>
        return(declarations(input));
        break;
      case 2: // BEGIN
        if(*input != BEGIN)
          return 0;
        input++;
        break;
      case 3: // <statement_sequence>
        return(statement_sequence(input));
        break;
      case 4: // END
        if(*input != END)
          return 0;
        input++;
        break;
      default:
        // Should not reach this point
        printf("ERROR: Invalid input\n");
        exit(1);
    }
  }
  return 1;
}

// <declarations> ::= VAR ident AS <type> SC <declarations> | epsilon
bool declarations(token_t *input) {
  for(int i = 0; i < 6; i++) {
    switch(i)
    {
      case 0:
        if()
    }
  }
}

// <type> ::= INT | BOOL
bool type(token_t *input) {
}

// <statement_sequence> ::= <statement> SC <statement_sequence> | epsilon
bool statement_sequence(token_t *input) {
}

void invalid_grammar_error() {
  printf("ERROR: Invalid grammar\n");
  exit(1);
} */
