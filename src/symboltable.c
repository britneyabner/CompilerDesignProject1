#include "symboltable.h"
#include "uthash.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// initializes symbol table
static symbol_table_t *identifiers = NULL;

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

int add_symbol(char *name) {
  if (find_symbol(name)) {
    // cant add duplicate symbol
    return 0;
  }

  symbol_table_t *symbol = NULL;
  symbol = (symbol_table_t *)malloc(sizeof *symbol);
  symbol->name = strdup(name);
  HASH_ADD_KEYPTR(hh, identifiers, symbol->name, strlen(symbol->name), symbol);

  return 1;
}
