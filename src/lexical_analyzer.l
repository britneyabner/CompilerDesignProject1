%{
#include <stdio.h>

#define num         1
#define boollit     2
#define ident       3
#define LP          4
#define RP          5
#define ASGN        6
#define SC          7
#define OP2         8
#define OP3         9
#define OP4         10
#define IF          11
#define THEN        12
#define ELSE        13
#define BEGIN_T     14  // "BEGIN" is reserved by flex
#define END         15
#define WHILE       16
#define DO          17
#define PROGRAM     18
#define VAR         19
#define AS          20
#define INT         21
#define BOOL        22
#define WRITEINT    23
#define READINT     24
%}

%%
[1-9][0-9]*|0                 {return num;}
false|true                    {return boollit;}
[A-Z][A-Z0-9]*                {return ident;}
"("                           {return LP;}
")"                           {return RP;}
":="                          {return ASGN;}
";"                           {return SC;}
"*"|"div"|"mod"               {return OP2;}
"+"|"-"                       {return OP3;}
"="|"!="|"<"|">"|"<="|">="    {return OP4;}
"if"                          {return IF;}
"then"                        {return THEN;}
"else"                        {return ELSE;}
"begin"                       {return BEGIN_T;}  
"end"                         {return END;}
"while"                       {return WHILE;}
"do"                          {return DO;}
"program"                     {return PROGRAM;}
"var"                         {return VAR;}
"as"                          {return AS;}
"int"                         {return INT;}
"bool"                        {return BOOL;}
"writeInt"                    {return WRITEINT;}
"readInt"                     {return READINT;}
[ \n\r]                       // ignore whitespace
<<EOF>>                       {return 0;}
.                             {return -1;}
%%

// converts token type int representation to string
char *token_string(int type) {
  switch(type) {
    case num:
      return "num";
      break;
    case boollit:
      return "boollit";
      break;
    case ident:
      return "ident";
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
    case BEGIN_T: // BEGIN is reserved by flex
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
    default: // if type > 24, program should never reach this point
      printf("ERROR: Invalid token type, %d\n", type);
      exit(1);
    }
}

// function to print token type and value
void print_token(char *type) {
  printf("Token: %s Value: %s\n", type, yytext);
}

int main()
{
  int code;

  // reads and prints token type and value until error or eof reached
  while(1) {
    code = yylex();
    switch(code) {
      case 0:   // EOF
        //printf("End of file\n");
        yyterminate();
        break;
      case -1:  // ERROR: Invlid Input
        printf("ERROR: Invalid input: %s\n", yytext);
        yyterminate();
        break;
      default:
        printf("Token: %s Value: %s\n", token_string(code), yytext);
        break;  
    }
  }
  return 0;
}
