%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
#include "racional.h"
#include "y.tab.h"

void RmWs(char* str);  
extern YYSTYPE yylval; 
%}

/* Expresiones regulares */
op [-+*/()]       
ws [ \t]+         
digits [0-9]      
number (0|[1-9]+{digits}*) 
im [i]            
fr [/]            

racionalnum {ws}*{number}{ws}*{fr}{ws}*{number}{ws}*

%%

{racionalnum} {
    int num, den;
    RmWs(yytext);                      
    //printf("(%s)", yytext);            
    sscanf(yytext,"%d/%d", &num, &den);
    
    yylval = creaRacional(num, den);   
    return RNUMBER;                    
}

{op} |
\n { 
    return *yytext; 
}

"=="|"=" { 
    return EQ; 
}

{ws} { 
    /* Ignora espacios sueltos */
} 

. { 
    /* Ignora caracteres no reconocidos */
}

%%

/* Función para eliminar espacios de la cadena */
void RmWs(char* str) {
    int i = 0, j = 0;
    char temp[strlen(str) + 1];
    strcpy(temp, str);
    
    while (temp[i] != '\0') {
        while (temp[i] == ' ') 
            i++;
        str[j] = temp[i];      
        i++;
        j++;
    }
    str[j] = '\0'; 
}