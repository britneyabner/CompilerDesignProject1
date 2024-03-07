%{
    #include <stdio.h>
    #include <string.h>

    typedef enum token {
        NUM,
        BOOLLIT,
        IDENT,
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
        _BEGIN, // BEGIN is resereved by Flex and Bison
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
%}

%%
[1-9][0-9]*|0                 return(NUM);
false|true                    return(BOOLLIT);
[A-Z][A-Z0-9]*                return(IDENT);
"("                           return(LP);
")"                           return(RP);
":="                          return(ASGN);
";"                           return(SC);
"*"|"div"|"mod"               return(OP2);
"+"|"-"                       return(OP3);
"="|"!="|"<"|">"|"<="|">="    return(OP4);
"if"                          return(IF);
"then"                        return(THEN);
"else"                        return(ELSE);
"begin"                       return(_BEGIN);
"end"                         return(END);
"while"                       return(WHILE);
"do"                          return(DO);
"program"                     return(PROGRAM);
"var"                         return(VAR);
"as"                          return(AS);
"int"                         return(INT);
"bool"                        return(BOOL);
"writeInt"                    return(WRITEINT);
"readInt"                     return(READINT);
[ \n\r]                       // ignore whitespace
<<EOF>>                       {exit(1);}
.                             {perror("Illegal input");}
%%

char *token_string(int token) {
  switch (token) {
  case NUM:
    return "NUM";
    break;
  case BOOLLIT:
    return "BOOLLIT";
    break;
  case IDENT:
    return "IDENT";
    break;
  case LP:
    return "LP";
    break;
  case RP:
    return "RP";
    break;
  case ASGN:
    return "ASGN";
    break;
  case SC:
    return "SC";
    break;
  case OP2:
    return "OP2";
    break;
  case OP3:
    return "OP3";
    break;
  case OP4:
    return "OP4";
    break;
  case IF:
    return "IF";
    break;
  case THEN:
    return "THEN";
    break;
  case ELSE:
    return "ELSE";
    break;
  case _BEGIN: // BEGIN is reserved by flex
    return "BEGIN";
    break;
  case END:
    return "END";
    break;
  case WHILE:
    return "WHILE";
    break;
  case DO:
    return "DO";
    break;
  case PROGRAM:
    return "PROGRAM";
    break;
  case VAR:
    return "VAR";
    break;
  case AS:
    return "AS";
    break;
  case INT:
    return "INT";
    break;
  case BOOL:
    return "BOOL";
    break;
  case WRITEINT:
    return "WRITEINT";
    break;
  case READINT:
    return "READINT";
    break;
  default: // if *token > 24, program should never reach this point
    printf("ERROR: Invalid token type, %d\n", token);
    exit(1);
  }
}

int main()
{
  FILE *fptr;
  fptr = fopen("output.txt", "w");
  // reads and prints token type and value until error or eof reached
  while(1) {
      token_t current_token = yylex(); 
      printf("Token: %s Value: %s\n", token_string(current_token), yytext);
  }
  fclose(fptr);
  return 0;
}
