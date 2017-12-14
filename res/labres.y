%{
#include <stdlib.h>
#include <stdio.h>
int yylex();
int yyerror(const char* mess);
int linenum = 1;
static char Lab1[3][3] = {
    {'E','_','_'},
    {'_','*','_'},
    {'_','_','S'},
};
extern int x;
extern int y;
extern void mur(int x,int y);
extern int deplacement(int x,int y);
extern int gagne();
extern int perdu();
%}

%token N
%token S 
%token E 
%token W
%token END

%start chemin
 

%%

chemin
:dir 
|dir chemin

dir
:N { --y; if(deplacement(x,y)==1) return 1; } 
|S { ++y; if(deplacement(x,y)==1) return 1;}
|E { ++x; if(deplacement(x,y)==1) return 1;}
|W { --x; if(deplacement(x,y)==1) return 1;}
|END {if(Lab1[x][y]=='S') gagne(); 
     else perdu();
     return 0;}










%%
#include "lex1.yy.c"
int x = 0;
int y = 0;
extern int linenum;

int deplacement(int x,int y)
{
   if(x<0||y<0||x>2||y>2)
   { yyerror("les cases n'esxistent pas");
     return 1;}
   else if(Lab1[x][y] == '*')
   {
       perdu();
       return 2;
   }
   else if(Lab1[x][y] == 'S')
   {
       gagne();
       return 0;
   }
   else 
       return 0;
}

int perdu()
{ fprintf(stdout,"perdu\n");
  exit(1);}

int gagne()
{ fprintf(stdout,"gagne\n");}

int yyerror(const char* mess)
{
    fprintf(stderr,"FATAL line %d : %s (near %s)\n", linenum,mess,yytext);
    exit(2);
}
int main (int argc, char ** argv )
{
    const char* mode = "r";
    if(argc == 1)
    {
        return yyparse();
    }
    else if (argc == 2)
    {
        FILE * fd = fopen(argv[1],mode);
        if (!fd)
        { fprintf(stderr, "FATAL :ne pas pouvoir ouvrir %s",argv[1]);
           exit(2); }
        yyin = fd;
        return yyparse();
    }
    else 
      {fprintf(stderr, "FATAL :le nombre d'argument doit etre 1ou 2");
       exit(3);
       }
      return 0;
}