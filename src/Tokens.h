/* All possible token types in the programming language */

#ifdef TOKENS_H_
#define TOKENS_H_

enum TokenType {
  RANGE_SEPARATOR,
  ASSIGN,
  LCURLY,
  RCURLY,
  COMMA,
  LPAREN,
  RPAREN,
  TYPE_REF,
  IDENTIFIER,
  NUMBER,
  TAGS,
  BEGIN,
  SEQUENCE,
  INTEGER,
  DATE,
  END,
};

#endif // TOKENS_H_
