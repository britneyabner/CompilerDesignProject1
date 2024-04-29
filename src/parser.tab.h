/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_SRC_PARSER_TAB_H_INCLUDED
# define YY_YY_SRC_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 12 "src/parser.y"

    #include "parsetree.h"
    #include "symboltable.h"
    
    #define MIN_NUM 0
    #define MAX_NUM 214783647

#line 57 "src/parser.tab.h"

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    NUM = 258,                     /* NUM  */
    BOOLLIT = 259,                 /* BOOLLIT  */
    IDENT = 260,                   /* IDENT  */
    LP = 261,                      /* LP  */
    RP = 262,                      /* RP  */
    ASGN = 263,                    /* ASGN  */
    SC = 264,                      /* SC  */
    OP2 = 265,                     /* OP2  */
    OP3 = 266,                     /* OP3  */
    OP4 = 267,                     /* OP4  */
    IF = 268,                      /* IF  */
    THEN = 269,                    /* THEN  */
    ELSE = 270,                    /* ELSE  */
    BEGIN_T = 271,                 /* BEGIN_T  */
    END = 272,                     /* END  */
    WHILE = 273,                   /* WHILE  */
    DO = 274,                      /* DO  */
    PROGRAM = 275,                 /* PROGRAM  */
    VAR = 276,                     /* VAR  */
    AS = 277,                      /* AS  */
    INT = 278,                     /* INT  */
    BOOL = 279,                    /* BOOL  */
    WRITEINT = 280,                /* WRITEINT  */
    READINT = 281                  /* READINT  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 21 "src/parser.y"

    char *sval;
    int ival;
    program_t *program_val;
    declarations_t *declarations_val;
    type_t  *type_val;
    statement_sequence_t *statement_sequence_val;
    statement_t *statement_val;
    assignment_t *assigment_val;
    if_statement_t *if_statement_val;
    else_clause_t *else_clause_val;
    while_statement_t *while_statement_val;
    write_int_t *write_int_val;
    expression_t *expression_val;
    simple_expression_t *simple_expression_val;
    term_t *term_val;
    factor_t *factor_val;

#line 119 "src/parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_SRC_PARSER_TAB_H_INCLUDED  */
