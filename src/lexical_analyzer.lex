%{
  #include <stdio.h>
  #include <string.h>

#define TAGS              1
#define BEGIN             2
#define SEQUENCE          3
#define INTEGER           4
#define DATE              5
#define END               6
#define TYPE_REF          7
#define IDENTIFIER        8
#define NUMBER            9
#define ASSIGN            10
#define RANGE_SEPARATOR   11
#define LCURLY            12
#define RCURLY            13
#define COMMA             14
#define LPAREN            15
#define RPAREN            16
#define VERT_LINE         17

%}

%%

"TAGS"                    {return(TAGS);}
"BEGIN"                   {return(BEGIN);}
"SEQUENCE"                {return(SEQUENCE);}
"INTEGER"                 {return(INTEGER);}
"DATE"                    {return(DATE);}
"END"                     {return(END);}
[A-Z][a-zA-Z0-9]*         {return(TYPE_REF);}
[a-z][a-zA-Z0-9]*         {return(IDENTIFIER);}
0|[1-9][0-9]*             {return(NUMBER);}
"::="                     {return(ASSIGN);}
".."                      {return(RANGE_SEPARATOR);}
"{"                       {return(LCURLY);}
"}"                       {return(RCURLY);}
","                       {return(COMMA);}
"("                       {return(LPAREN);}
")"                       {return(RPAREN);}
"|"                       {return VERT_LINE;}
[ \t\n\r]                 //skip whitespace
<<EOF>>                   {
                            printf("End of file\n");
                            yyterminate();
                          }


%%

int main()
{
  int code;

  while(1) {
    code = yylex();
    switch(code) {
      case TAGS:
        printf("Token: TAGS Text: %s\n", yytext);
        break;
      case BEGIN:
        printf("Token: BEGIN Text: %s\n", yytext);
        break;
      case SEQUENCE:
        printf("Token: SEQUENCE Text: %s\n", yytext);
        break;
      case INTEGER:
        printf("Token: INTEGER Text: %s\n", yytext);
        break;
      case DATE:
        printf("Token: DATE Text: %s\n", yytext);
        break;
      case END:
        printf("Token: END Text: %s\n", yytext);
        break;
      case TYPE_REF:
        printf("Token: TYPE_REF Text: %s\n", yytext);
        break;
      case IDENTIFIER:
        printf("Token: IDENTIFIER Text: %s\n", yytext);
        break;
      case NUMBER:
        printf("Token: NUMBER Text: %s\n", yytext);
        break;
      case ASSIGN:
        printf("Token: ASSIGN Text: %s\n", yytext);
        break;
      case RANGE_SEPARATOR:
        printf("Token: RANGE_SEPARATOR Text: %s\n", yytext);
        break;
      case LCURLY:
        printf("Token: LCURLY Text: %s\n", yytext);
        break;
      case RCURLY:
        printf("Token: RCURLY Text: %s\n", yytext);
        break;
      case COMMA:
        printf("Token: COMMA Text: %s\n", yytext);
        break;
      case LPAREN:
        printf("Token: LPAREN Text: %s\n", yytext);
        break;
      case RPAREN:
        printf("Token: RPAREN Text:%s\n", yytext);
        break;
      case VERT_LINE:
        printf("Token: VERT_LINE Text:%s\n", yytext);
        break;
      default:
        printf("ERROR: Invalid code %s\n", yytext);
        yyterminate();
        break;
    }
  }

  return 0;
}
