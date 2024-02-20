%{
#include <stdio.h>
#include <string.h>

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
"*"|"div"|"mod"               {return OP4;}
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


void print_token(char* token) {
  printf("Token: %s Value: %s\n", token, yytext);
}

int main()
{
  int code;

  while(1) {
    code = yylex();
    switch(code) {
      case 0:   // EOF
        printf("End of file\n");
        yyterminate();
        break;
      case -1:  // ERROR
        printf("ERROR: Invalid input: %s\n", yytext);
        yyterminate();
        break;
      case num:
        print_token("num");
        break;
      case boollit:
        print_token("boollit");
        break;
      case ident:
        print_token("idnet");
        break;
      case LP:
        print_token("LP");
        break;
      case RP:
        print_token("RP");
        break;
      case ASGN:
        print_token("ASGN");
        break;
      case SC:
        print_token("SC");
        break;
      case OP2:
        print_token("OP2");
        break;
      case OP3:
        print_token("OP3");
        break;
      case OP4:
        print_token("OP4");
        break;
      case IF:
        print_token("IF");
        break;
      case THEN:
        print_token("THEN");
        break;
      case ELSE:
        print_token("ELSE");
        break;
      case BEGIN_T:
        print_token("BEGIN");
        break;
      case END:
        print_token("END");
        break;
      case WHILE:
        print_token("WHILE");
        break;
      case DO:
        print_token("DO");
        break;
      case PROGRAM:
        print_token("PROGRAM");
        break;
      case VAR:
        print_token("VAR");
        break;
      case AS:
        print_token("AS");
        break;
      case INT:
        print_token("INT");
        break;
      case BOOL:
        print_token("BOOL");
      default:
        break;
      case WRITEINT:
        print_token("WRITEINT");
        break;
      case READINT:
        print_token("READINT");
        break;
      defualt:
        printf("ERROR: Invalid token: %s of with value: %s\n", code, yytext);
        break;
    }
  }
  return 0;
}
