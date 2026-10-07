%{
#include <stdio.h>
#include <stdlib.h>
#include "racional.h"

/* Declaraciones externas */
extern int yylex(void);
extern int yyerror(const char* s);
%}

/* Definición de tokens */
%token RNUMBER EQ

/* Precedencia y asociatividad */
%left '+' '-'
%left '*' '/'
%right UMINUS

%%

/* Reglas principales */
list:
      | list '\n'
      | list exp '\n'        { imprimirR($2); }
      | list exp EQ exp '\n' {
            if(esIgual($2, $4))
                printf("-> Verdadero (Son iguales)\n");
            else
                printf("-> Falso (Son diferentes)\n");
        }
      | list error '\n'      { yyerrok; }
      ;

exp:    RNUMBER           { if(!$1) { yyerror("denominador cero"); YYERROR; }
                            $$ = $1; }
      | exp '+' exp       { $$ = racionalSuma($1, $3); }
      | exp '-' exp       { $$ = racionalResta($1, $3); }
      | exp '*' exp       { $$ = racionalMultiplicar($1, $3); }
      | exp '/' exp       { $$ = racionalDividir($1, $3);
                            if(!$$) { yyerror("division entre cero"); YYERROR; } }
      | '-' exp %prec UMINUS { $$ = creaRacional(-numerador($2), denominador($2)); }
      | '(' exp ')'       { $$ = $2; }
      ;

%%
