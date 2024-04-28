%{
#include "parser.tab.h"
#include "symboltable.h"
%}

%%
[1-9][0-9]*|0   {
    yylval.ival = atoi(yytext);
    return NUM;
}

false|true {
    yylval.sval = strdup(yytext);
    return BOOLLIT;
}

[A-Z][A-Z0-9]* {
        yylval.sval = strdup(yytext);
        return IDENT;
}

"("                           return(LP);
")"                           return(RP);
":="                          return(ASGN);
";"                           return(SC);

"*"|"div"|"mod" {
    yylval.sval = strdup(yytext);
    return OP2;
}

"+"|"-" {
    yylval.sval = strdup(yytext);
    return OP3;
}

"="|"!="|"<"|">"|"<="|">="  {
    yylval.sval = strdup(yytext);
    return OP4;
}

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
.                             { perror("Unknown token."); }
%%
