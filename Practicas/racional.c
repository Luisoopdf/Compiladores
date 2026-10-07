#include <stdio.h>
#include <stdlib.h>
#include "racional.h"

/* yyparse inicia el análisis sintáctico generado por Yacc. */
extern int yyparse(void);

/* El programa lee la entrada estándar y la procesa con el parser. */
int main() { return yyparse(); }

/* Yacc llama a yyerror cuando encuentra un error sintáctico o semántico. */
int yyerror(const char* s) { 
  printf("%s\n", s); 
  return 0; 
}

/* Reserva memoria para un racional y valida que el denominador no sea cero. */
Racional *creaRacional(int num, int den){
   Racional *nvo;
   if(den==0)
	return (Racional *)NULL;
   nvo=(Racional *)malloc(sizeof(Racional));
   if(!nvo){
	puts("no hay memoria para crear Racional ");
        return (Racional *)NULL;
   }  
   nvo->num=num;
   nvo->den=den;
   return nvo;
}

/* Reemplaza el numerador y el denominador de un racional existente. */
void asignar(Racional *r, int num, int den){
   r -> num = num; r -> den = den;
}

/* Devuelve el numerador del racional. */
int numerador(Racional *r){ return r ->num; }

/* Devuelve el denominador del racional. */
int denominador(Racional *r){ return r ->den; }

/* Suma dos racionales usando un denominador común. */
Racional* racionalSuma(Racional *r, Racional *s){
	int nvonum = (r -> num * s -> den) + (s -> num * r -> den);
	int nvoden = r -> den * s -> den;
	Racional *nvo = creaRacional(nvonum, nvoden);
	return nvo; 
}

/* Resta el segundo racional del primero usando un denominador común. */
Racional* racionalResta(Racional *r, Racional *s){
	int nvonum = (r -> num * s -> den) - (s -> num * r -> den);
	int nvoden = r -> den * s -> den;
	Racional *nvo = creaRacional(nvonum, nvoden);
	return nvo; 
}

/* Multiplica los numeradores y los denominadores de dos racionales. */
Racional* racionalMultiplicar(Racional *r, Racional *s){
	int nvonum = r -> num * s -> num;
	int nvoden = r -> den * s -> den;
	Racional *nvo = creaRacional(nvonum, nvoden);
	return nvo; 
}

/* Divide dos racionales invirtiendo el segundo y multiplicando. */
Racional* racionalDividir(Racional *r, Racional *s){
	int nvonum = r -> num * s -> den;
	int nvoden = r -> den * s -> num;
	Racional *nvo = creaRacional(nvonum, nvoden);
	return nvo; 
}

/* Compara dos racionales mediante multiplicación cruzada. */
int esIgual(Racional *r, Racional *s){
	return (r -> num * s -> den) == (r -> den * s -> num);
}

/* Convierte el apuntador recibido y muestra el racional en pantalla. */
void imprimirR(void *r){
	Racional *p = (Racional*)r;
	printf("(%d / %d)\n",p -> num, p -> den);
}

/* Crea una copia independiente del racional recibido. */
Racional *copiar(Racional *r){
	return creaRacional(r -> num, r -> den);
}