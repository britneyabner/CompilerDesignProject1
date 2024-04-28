#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include "uthash.h"

typedef enum symbol_type {
  INTEGER_TYPE,
  BOOLEAN_TYPE,
} symbol_type_t;

typedef struct symbol_table {
  const char *name;
  symbol_type_t type;
  UT_hash_handle hh; /* makes structure hashable */
} symbol_table_t;

int find_symbol(char *name);
int add_symbol(char *name);

#endif // SYMBOLTABLE_H
