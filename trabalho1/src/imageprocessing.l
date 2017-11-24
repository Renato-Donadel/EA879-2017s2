%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
void yyerror(char *);

#include "y.tab.h"
%}
%%
[a-z]  {
        yylval.ival = yytext[0] - 'a';
        return VAR;
       }
([0-9]+[.][0-9]+) {
	  yylval.str = strdup(yytext);
	  return N;
	}
\" { return ASPA; }
[a-zA-Z0-9\.]+  {
        for (int i = 0; i < yyleng; i++ )
          yylval.strval[i] = yytext[i];
          yylval.strval[yyleng] = '\0';
          printf ("Achei nome: %s\n", yylval.strval);
        return STRING;
       }
[*/]     {
	  yylval.str = strdup(yytext);
          return AUXILIAR;
        }

[=]     {
          return IGUAL;
        }

[\]\[]  {
          yylval.ival = yytext[0];
          return CHAVE;
        }


\n	{
         return EOL;
  	}

[ \t]+ ;

.     {printf("**%s**\n", yytext);
yyerror("Token nao reconhecido!\n");}

%%

int  yywrap() {
  return 1;
}
