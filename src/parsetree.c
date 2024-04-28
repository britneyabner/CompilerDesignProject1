#include "parsetree.h"
#include "symboltable.h"
#include <stdbool.h>
#include <stdio.h>

#define COMPILE_FAILURE 0
#define COMPILE_SUCCESS 1

static int print_program(program_t *node);
static int print_declarations(declarations_t *node);
static int print_statement_sequence(statement_sequence_t *node);
static int print_type(type_t *node);
static int print_statement(statement_t *node);
static int print_assignemt(assignment_t *node);
static int print_if_statement(if_statement_t *node);
static int print_while_statement(while_statement_t *node);
static int print_write_int(write_int_t *node);
static int print_else_clause(else_clause_t *node);
static int print_expression(expression_t *node);
static int print_simple_expression(simple_expression_t *node);
static int print_term(term_t *node);
static int print_factor(factor_t *node);
static void print_indent(void);

static int indent = 0; /** number of tabs to print on each new line */

/**
 * Compiles parse tree to C code and prints.
 *
 * @param root Root node of the parse tree.
 * @return 1 if ran sucessfully, 0 otherwise
 */
int compile(program_t *root) { return print_program(root); }

/**
 * Parses and prints program_t
 *
 * @param node Pointer to program_t node to print
 * @return 1 if ran successfully, 0 otherwise
 */
static int print_program(program_t *node) {
  // fails if node does not exist
  if (!node) {
    return COMPILE_FAILURE;
  }
  printf("#include <stdio.h>\n");
  printf("#include <stdbool.h>\n\n");

  // parse and print declarations_t subtree
  if (!print_declarations(node->declarations_ptr)) {
    return COMPILE_SUCCESS;
  }

  // BEGIN
  printf("\nint main() {\n");
  indent++;

  // parse and print statememt_sequence_t subtree
  if (!print_statement_sequence(node->statement_sequence_ptr)) {
    // if failed
    return COMPILE_FAILURE;
  }

  // END
  print_indent();
  printf("return 0;\n}");
  indent--;

  return COMPILE_SUCCESS;
}

/**
 * Parses and prints declarations_t
 *
 * @param node Pointer to declarations_t node to print, can be null.
 * @return 1 if ran successfully, 0 otherwise
 */
static int print_declarations(declarations_t *node) {

  // if epsilon then do nothing
  if (!node) {
    return COMPILE_SUCCESS;
  }

  // VAR AS <type>
  // parse and print type_t subtree
  if (!print_type(node->type_ptr)) {
    return COMPILE_FAILURE;
  }

  // IDENT
  // must have an identifier
  if (!node->ident) {
    return COMPILE_FAILURE;
  }

  // variables default to 0/false
  printf("%s = 0;\n", node->ident);

  // <declarations_t>
  return print_declarations(node->declarations_ptr);
}

/**
 * Parses and prints type_t subtree
 *
 * @param node Pointer to type_t node to print.
 * @return 1 if ran successfully, 0 otherwise
 */
static int print_type(type_t *node) {
  if (!node) {
    return COMPILE_FAILURE;
  }

  switch (node->data_type) {
  case INTEGER_TYPE:
    printf("int ");
    break;
  case BOOLEAN_TYPE:
    printf("bool ");
    break;
  }

  return COMPILE_SUCCESS;
}

/** Parses and prints statement_sequence_t subtree
 *
 * @param node Pointer to statement_sequence_t node to print.
 * @return 1 if ran successfully, 0 otherwise
 */
static int print_statement_sequence(statement_sequence_t *node) {
  // if epsilon do nothing
  if (!node) {
    return COMPILE_SUCCESS;
  }

  // parse and print statement_t subtree
  if (!print_statement(node->statement_ptr)) {
    return COMPILE_FAILURE;
  }

  printf("\n");

  // parse statement_sequence_t subtree
  if (!print_statement_sequence(node->statement_sequence_ptr)) {
    return COMPILE_FAILURE;
  }

  return COMPILE_SUCCESS;
}

/** Parses and prints statement_t subtree.
 *
 * @param node Pointer to statement_t node
 * @return 1 if copy value of a pointerran successfully, 0 otherwise
 */
static int print_statement(statement_t *node) {
  if (!node) {
    return COMPILE_FAILURE;
  }

  print_indent();

  if (node->assignment_ptr) {
    return print_assignemt(node->assignment_ptr);
  } else if (node->if_statement_ptr) {
    return print_if_statement(node->if_statement_ptr);
  } else if (node->while_statement_ptr) {
    return print_while_statement(node->while_statement_ptr);
  } else if (node->write_int_ptr) {
    return print_write_int(node->write_int_ptr);
  } else {
    return COMPILE_FAILURE;
  }
}

/** Parsers and prints assignment_t subtree.
 *
 * @param node Pointer to assignment_t node.
 * @return 1 if ran successfully, 0 otherwise
 */
static int print_assignemt(assignment_t *node) {
  // node must exist
  if (!node) {
    return COMPILE_FAILURE;
  }

  // ident ASGN <expression> | ident ASGN READINT
  // in C, user input is done with scanf, which is not an assignment, so
  // the printing format is different for <expression> or READINT
  // ident ASGN READINT
  if (!(node->expression_ptr)) {
    printf("scanf(\"%%d\", %s);", node->ident);
    return COMPILE_SUCCESS;
  } else if (node->expression_ptr) { // ident ASGN <expression>
    printf("%s = ", node->ident);
    if (!(print_expression(node->expression_ptr))) {
      return COMPILE_FAILURE;
    }

    printf(";");
  } else {
    return COMPILE_FAILURE;
  }

  return COMPILE_SUCCESS;
}

static int print_expression(expression_t *node) {
  // node must exist
  if (!node) {
    return COMPILE_FAILURE;
  }

  // <simple_expression>
  if (!(node->op4) && !(node->simple_expression_two_ptr)) {
    return print_simple_expression(node->simple_expression_one_ptr);
  }

  // <simple_expression> OP4 <simple_expression>
  if (!print_simple_expression(node->simple_expression_one_ptr)) {
    return COMPILE_FAILURE;
  }
  if (!(node->op4)) {
    return COMPILE_FAILURE;
  }
  printf(" %s ", node->op4);
  if (!print_simple_expression(node->simple_expression_two_ptr)) {
    return COMPILE_FAILURE;
  }

  return COMPILE_SUCCESS;
}

static int print_simple_expression(simple_expression_t *node) {
  if (!node) {
    return COMPILE_FAILURE;
  }

  if (!(node->term_two_ptr) && !(node->op3)) {
    return print_term(node->term_one_ptr);
  } else if (!(node->op3) || !(node->term_two_ptr)) {
    return COMPILE_FAILURE;
  }

  if (!print_term(node->term_one_ptr)) {
    return COMPILE_FAILURE;
  }
  printf(" %s ", node->op3);
  if (!print_term(node->term_two_ptr)) {
    return COMPILE_FAILURE;
  }

  return COMPILE_SUCCESS;
}

static int print_term(term_t *node) {
  // node must exist
  if (!node) {
    return COMPILE_FAILURE;
  }

  if (!(node->op2) || !(node->factor_two_ptr)) {
    return print_factor(node->factor_one_ptr);
  }

  if (!print_factor(node->factor_one_ptr)) {
    return COMPILE_FAILURE;
  }

  if (!(node->op2)) {
    return COMPILE_FAILURE;
  }
  printf(" %s ", node->op2);

  if (!print_factor(node->factor_two_ptr)) {
    return COMPILE_FAILURE;
  }

  return COMPILE_SUCCESS;
}

static int print_factor(factor_t *node) {
  // node must exist
  if (!node) {
    return COMPILE_FAILURE;
  }

  // ident | num | boolit | LP <expression> RP
  if (node->ident && !(node->num || node->boollit || node->expression_ptr)) {
    printf("%s", node->ident);
  } else if (node->num &&
             !(node->ident || node->boollit || node->expression_ptr)) {
    printf("%d", node->num);
  } else if (node->boollit &&
             !(node->ident || node->num || node->expression_ptr)) {
    printf("%s", node->boollit);
  } else if (node->expression_ptr &&
             !(node->num || node->boollit || node->ident)) {
    printf("(");
    if (!print_expression(node->expression_ptr)) {
      return COMPILE_FAILURE;
    }
    printf(")");
  } else {
    return COMPILE_FAILURE;
  }

  return COMPILE_SUCCESS;
}

static int print_if_statement(if_statement_t *node) {
  // node must exist
  if (!node) {
    return COMPILE_FAILURE;
  }

  // IF
  printf("if (");

  // <expression>
  if (!print_expression(node->expression_ptr)) {
    return COMPILE_FAILURE;
  }
  // THEN
  printf(") {\n");
  indent++;

  // <statement_sequence>
  if (!print_statement_sequence(node->statement_sequence_ptr)) {
    return COMPILE_FAILURE;
  }

  // <else_clause>
  if (!print_else_clause(node->else_clause_ptr)) {
    return COMPILE_FAILURE;
  }

  // END
  indent--;
  print_indent();
  printf("}");

  return COMPILE_SUCCESS;
}

static int print_else_clause(else_clause_t *node) {
  // if epsilon node nothing
  if (!node) {
    return COMPILE_SUCCESS;
  }

  // ELSE
  printf("} else {\n");
  indent++;

  // <statement_sequence>
  if (!print_statement_sequence(node->statement_sequence_ptr)) {
    return COMPILE_FAILURE;
  }

  printf("}\n");

  return COMPILE_SUCCESS;
}

static int print_while_statement(while_statement_t *node) {
  return COMPILE_SUCCESS;
}

static int print_write_int(write_int_t *node) {
  if (!node) {
    return COMPILE_FAILURE;
  }

  printf("printf(\"%%d\", ");
  if (!print_expression(node->expression_ptr)) {
    return COMPILE_FAILURE;
  }
  printf(");");

  return COMPILE_SUCCESS;
}

/** Prints tabs based on current indent level
 */
static void print_indent(void) {
  for (int i = 0; i < indent; i++) {
    printf("\t");
  }
}
