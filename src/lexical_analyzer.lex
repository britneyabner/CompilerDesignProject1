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
#define BEGIN_T     14
#define END         15
#define WHILE       16
#define DO          17
#define PROGRAM     18
#define VAR         19
#define AS          20
#define INT         21
#define BOOL        22
#define WRITEINT   23
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
"begin"                       {return BEGIN_T;}  // "BEGIN" is reserved by flex
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
<<EOF>>                       {return 0;}
%%

int main()
{
  int code;

  while(1) {
    code = yylex();
    switch(code) {
      case 0:
        printf("End of file\n");
        yyterminate();
      default:
        printf("Token %s Text: %s\n", yylex(), yytext);
    }
  }

  return 0;
}
