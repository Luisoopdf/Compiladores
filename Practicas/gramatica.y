%{

#include <stdio.h>
#include <stdlib.h>
#include "racional.h"

extern int yylex(void);
extern int yyerror(const char* s);
%}

/*TOKENS: Las piezas que Flex ya reconoció y nos envía */
%token RNUMBER EQ

/* 3. PRECEDENCIA: Orden matemático (de menor a mayor prioridad) */
%left '+' '-'     
%left '*' '/'   
%right UMINUS

%%

/*GRAMÁTICA*/

/* 'list': Mantiene el programa encendido esperando operaciones (ciclo infinito) */
list:
      | list '\n'            /* Si el usuario solo da Enter, no hace nada */
      | list exp '\n'        { imprimirR($2); } /* Si escribe una operación ($2), imprime el resultado */              
      | list exp EQ exp '\n' {
                             /* Compara si la primera fracción ($2) es igual a la segunda ($4) */
            if(esIgual($2, $4))
                printf("-> Verdadero (Son iguales)\n");
            else
                printf("-> Falso (Son diferentes)\n");
        }
        
      | list error '\n'      { yyerrok; } /* Si hay un error de escritura, se recupera y NO cierra el programa */
      ;

/* Regla 'exp'
   - $$ es la caja donde se guarda el resultado.
   - $1, $2, $3 representan las posiciones de los elementos leídos de izquierda a derecha. */
exp:    RNUMBER           { /* Si la fracción es inválida lanza error */
                            if(!$1) { yyerror("denominador cero"); YYERROR; }
                            $$ = $1; /* Si es válida, el resultado es el número mismo */ }
                            
      | exp '+' exp       { $$ = racionalSuma($1, $3); }       /* Suma $1 y $3 */
      
      | exp '-' exp       { $$ = racionalResta($1, $3); }      /* Resta $3 de $1 */
      
      | exp '*' exp       { $$ = racionalMultiplicar($1, $3); }/* Multiplica $1 y $3 */
      
      | exp '/' exp       { $$ = racionalDividir($1, $3);      /* Divide $1 entre $3 */
                            /* Si tras dividir queda un cero abajo, frena y lanza error */
                            if(!$$) { yyerror("division entre cero"); YYERROR; } }
                            
      | '-' exp %prec UMINUS { /* Toma la fracción en $2 y le vuelve negativo el numerador */
                            $$ = creaRacional(-numerador($2), denominador($2)); }
                            
      | '(' exp ')'       { $$ = $2; } 
                            /* El resultado es lo que está adentro del paréntesis ($2) */
      ;

%%