#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include "uthash.h"

/** Variable type
 */
typedef enum symbol_type {
  /** Integer variable */
  INTEGER_TYPE,
  /** Boolean variable */
  BOOLEAN_TYPE,
} symbol_type_t;

/** Symbol table utilizing uthash.h
 */
typedef struct symbol_table {
  /** Name/key */
  const char *name;
  /** Typep of variable */
  symbol_type_t type;
  /** Required for uthash, makes the struct hashable */
  UT_hash_handle hh;
} symbol_table_t;

/** Determines if a symbol exists in the symbol table.
 *
 * @parm name String name/key of the symbol
 * @return 1 if found, 0 otherwise
 */
int find_symbol(char *name);

/** Attempts to add a symbol to the symbol table
 *
 * @param name String name/key of the symbol
 * @return 1 if added successfully, 0 otherwise
 */
int add_symbol(char *name);

#endif // SYMBOLTABLE_H
