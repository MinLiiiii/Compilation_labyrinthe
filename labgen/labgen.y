%{
#include <stdlib.h>
#include <stdio.h>
int yylex();
int yyerror(const char* s);
%}



%token IDENT
%token NUM
%token DIR
%token FIN
%token SIZE
%token IN
%token OUT
%token WALL
%token UNWALL
%token TOGGLE
%token PTA
%token PTD
%token R
%token F
%token FOR
%token WH
%token MD
%token SHOW
%token vir 
%token max
%token e
%token paren_left
%token paren_right
%token plus
%token division
%token sous
%token mod
%token mult
%token sup
%token com
%left plus  
%left division
%left sous
%left mod
%left mult
%right e 
%left vir
%start lab
%%


lab
:labyrinthe
|labyrinthe lab
;

labyrinthe
:max e CNUM FIN 
|SIZE size_option FIN 
|IN PT FIN 
|OUT out_l FIN 
|WALL option_mur FIN 
|UNWALL option_mur FIN 
|TOGGLE option_mur FIN 
|WH PT list_point FIN 
|MD PT dest_list FIN 
|com com_option
;

com_option
:IDENT
|IDENT com_option
;
size_option
:CNUM vir CNUM
|max
|max CNUM
|max CNUM vir max CNUM 
|max vir max CNUM
;

CNUM
:plus NUM
|sous NUM
|NUM
;

xcst
:expr
;

expr 
: IDENT
| CNUM
| paren_left expr paren_right
| expr plus expr
| expr sous expr
| expr mult expr
| expr division  expr
| expr mod  expr
;


PT
: paren_left  xcst vir  xcst paren_right
| paren_left max_option vir max_option  paren_right
| paren_left max_option vir xcst paren_right
| paren_left xcst vir max_option paren_right
;


max_option
:max CNUM
|max
;

out_l 
: PT
| PT out_l
;

option_mur
:FIN
|PTA suite_pts
|PTD suite_deplace
|R r_sub_option
|FOR args_for
;


suite_pts
:PT 
|PT suite_pts
;

suite_deplace
:PT
|PT suite_deplace
|PT ':' CNUM suite_deplace
|PT ':' '*' suite_deplace
;

r_sub_option 
:PT PT
|F PT PT
;

range 
:'['xcst':'xcst']'
|'['xcst':'xcst':'xcst']'
|'['xcst':'xcst'['
|'['xcst':'xcst':'xcst'['
;

range_list 
:range
|range_list range
;

args_for
: var_list IN range_list '(' expr ',' expr ')'
;

var_list 
:var_list IDENT
|IDENT
;

list_point 
:sous sup PT
|sous sup PT list_point
;


dest_list
:DIR PT
|DIR PT dest_list
;



%%
#include "lex.yy.c"


int main(int argc, char ** argv) 
{
 const char* mode1 = "r";
 const char* mode2 = "w";
 if(argc == 1)
 { return yyparse();}
 if(argc == 2)
 { FILE *fd = fopen(argv[1],mode1);
   if (!fd)
  { fprintf(stderr, "FATAL :ne pas pouvoir ouvrir %s",argv[1]);
    exit(2); }
   yyin = fd;
   return yyparse(); }
 if (argc == 3)
 { if (argv[1] != "_")
   {FILE *fd = fopen(argv[1],mode1);
     if (!fd)
   { fprintf(stderr, "FATAL :ne pas pouvoir ouvrir %s",argv[1]);
    exit(2); }
   yyin = fd;}
   FILE *fo = fopen(argv[2],mode2);
   if (!fo)
   {  fprintf(stderr, "FATAL :ne pas pouvoir ouvrir %s",argv[2]);
       exit(3);}
   yyout = fo;
   return yyparse();
 }
 else 
    {fprintf(stderr, "FATAL :le nombre d'argument doit etre 1,2 ou 3");
    exit(4);}
  return 0;
}
 
int yyerror(const char* s)
{
  fprintf(stderr, "error: %s near : %s\n",s,yytext);
  exit(1);
}
  
