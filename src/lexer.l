%{
#include "grammar.tab.h"

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
"begin"                       return(BEGIN_T);
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
"%".*\n                       // ignore comment
%%
