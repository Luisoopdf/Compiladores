#include <string.h>

/* Estructura que representa un número racional mediante numerador y denominador. */
struct racional {
	int num, den;
}; 

/* Racional es el nombre corto de la estructura y RacionalAP es un apuntador a ella. */
typedef struct racional Racional;
typedef struct racional* RacionalAP;

/* Funciones para crear, modificar, consultar y operar números racionales. */
Racional *creaRacional(int num, int den);
void asignar(Racional *r, int num, int den);
int numerador(Racional *r);
int denominador(Racional *r);
Racional* racionalSuma(Racional *r, Racional *s);
Racional* racionalResta(Racional *r, Racional *s);
Racional* racionalMultiplicar(Racional *r, Racional *s);
Racional* racionalDividir(Racional *r, Racional *s);
int esIgual(Racional *r, Racional *s);
void imprimirR(void *r);
Racional *copiar(Racional *r);

/* YYSTYPE define el tipo de valor semántico que Flex entrega a Yacc.
   Cada elemento de tipo RacionalAP en la pila semántica representa
   un racional asociado con un token o con una expresión reducida. */
#define YYSTYPE RacionalAP
