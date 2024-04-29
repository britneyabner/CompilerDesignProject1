#include "symboltable.h"
#include "uthash.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// initializes symbol table
static symbol_table_t *identifiers = NULL;

/** Determines if a symbol exists in the symbol table.
 *
 * @parm name String name/key of the symbol
 * @return 1 if found, 0 otherwise
 */
int find_symbol(char *name) {
  symbol_table_t *symbol = NULL;
  symbol = (symbol_table_t *)malloc(sizeof *symbol);
  HASH_FIND_STR(identifiers, name, symbol);
  if (symbol) {
    free(symbol);
    return 1;
  }
  return 0;
  free(symbol);
}

/** Attempts to add a symbol to the symbol table
 *
 * @param name String name/key of the symbol
 * @return 1 if added successfully, 0 otherwise
 */
int add_symbol(char *name, symbol_type_t type) {
  if (find_symbol(name)) {
    // cant add duplicate symbol
    return 0;
  }

  symbol_table_t *symbol = NULL;
  symbol = (symbol_table_t *)malloc(sizeof *symbol);
  symbol->name = strdup(name);
  symbol->type = type;
  HASH_ADD_KEYPTR(hh, identifiers, symbol->name, strlen(symbol->name), symbol);

  return 1;
}
