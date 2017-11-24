%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "imageprocessing.h"
#include <FreeImage.h>
void yyerror(char *c);
int yylex(void);
%}
%union {
  char    strval[50];
  char    *str;
  int     ival;
  float   fval;
}
%token <strval> STRING 
%token <str> IGUAL AUXILIAR N 
%token <ival> VAR EOL ASPA CHAVE
%left SOMA

%%

PROGRAMA:
        PROGRAMA EXPRESSAO EOL
        |
        ;

EXPRESSAO:
    | STRING IGUAL STRING {
        printf("Copiando %s para %s\n", $3, $1);
        imagem I = abrir_imagem($3);
        printf("Li imagem %d por %d\n", I.width, I.height);
	int x1 = I.width;
	int y2 = I.height;

        salvar_imagem($1, &I);
      }
    | CHAVE STRING CHAVE  {
        imagem I = abrir_imagem($2);
        float valor = valor_maximo(I);
        printf("valor maximo %.2f", valor);
        liberar_imagem(&I);
     }
    ;
%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
  FreeImage_Initialise(0);
  yyparse();
  return 0;

}
