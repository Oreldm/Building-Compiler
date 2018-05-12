%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
%}

%union{int food; 
struct calories { int totalCalories, desserts , mealNumber, vegtablesFruits; } calories; }  /* Yacc definitions */

%start day
%token START_MEAL 
%token VEGETABLE 
%token FRUIT 
%token MEAT 
%token BREAD 
%token DESSERT
%token END_MEAL

%type<calories> list_of_meals meal list_of_servings serving

%%

/* descriptions of expected inputs corresponding actions (in C) */

day: list_of_meals {if(19<$1.totalCalories)printf("Too Many Calories: total is %d  \n\n",$1.totalCalories); else if($1.vegtablesFruits!=10 && $1.desserts!=10) printf("everything is OK. \n\n");}

list_of_meals:  list_of_meals meal {$$.totalCalories=$1.totalCalories+$2.totalCalories; $$.mealNumber=$$.mealNumber+1; if($2.vegtablesFruits<2) printf("Meal #%d: not enough veggies/fruit\n",$$.mealNumber); if($2.desserts>1)printf("Meal #%d: too much dessert\n",$$.mealNumber); if($2.vegtablesFruits<2) $$.vegtablesFruits=10; if($2.desserts>1) $$.desserts=10;}

list_of_meals:  /* empty  */ {$$.totalCalories=0;}

meal: START_MEAL list_of_servings END_MEAL {$$.totalCalories=$2.totalCalories; $$.desserts=$2.desserts; $$.vegtablesFruits=$2.vegtablesFruits;}

list_of_servings: list_of_servings ',' serving {$$.totalCalories=$1.totalCalories+$3.totalCalories; $$.desserts=$1.desserts+$3.desserts; $$.vegtablesFruits=$1.vegtablesFruits+$3.vegtablesFruits;}

list_of_servings: serving {$$.totalCalories=$1.totalCalories; $$.desserts=$1.desserts; $$.vegtablesFruits=$1.vegtablesFruits;}

serving:  VEGETABLE {$$.totalCalories=1; $$.vegtablesFruits=$$.vegtablesFruits+1;} | FRUIT {$$.totalCalories=2; $$.vegtablesFruits=$$.vegtablesFruits+1; } | MEAT {$$.totalCalories=4;} | BREAD {$$.totalCalories=3;} | DESSERT { $$.totalCalories=yylval.food; $$.desserts=$$.desserts+1;}

%%                     /* C code */


int main (void) {
	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

