%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
%}

%union{int totalCalories; int fruitVegtables; int desserts; }/* Yacc definitions */

%start day
%token START_MEAL 
%token VEGETABLE 
%token FRUIT 
%token MEAT 
%token BREAD 
%token DESSERT 
%token END_MEAL

%%

/* descriptions of expected inputs     corresponding actions (in C) */

day: list_of_meals

list_of_meals:  list_of_meals meal {printf("1");}

list_of_meals:  /* empty  */ {printf("2");}

meal: START_MEAL list_of_servings END_MEAL {printf("3");}

list_of_servings: list_of_servings ',' serving {printf("4");}

list_of_servings: serving {printf("5");}

serving:  VEGETABLE | FRUIT | MEAT | BREAD | DESSERT {printf("6");}

%%                     /* C code */


int main (void) {
	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

