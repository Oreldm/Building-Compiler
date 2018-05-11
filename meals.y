%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
%}

%union{int totalCalories; float desserts; long mealNumber; int food; }  /* Yacc definitions */

%start day
%token START_MEAL 
%token VEGETABLE 
%token FRUIT 
%token MEAT 
%token BREAD 
%token DESSERT
%token END_MEAL

%type<totalCalories> list_of_meals meal list_of_servings serving

%%

/* descriptions of expected inputs corresponding actions (in C) */

day: list_of_meals {if(19<$1)printf("Too Many Calories: total is %d",$1); }

list_of_meals:  list_of_meals meal {$$=$1+$2; yylval.mealNumber=yylval.mealNumber+1;  printf("total in meal %d\n",yylval.mealNumber);}

list_of_meals:  /* empty  */ {$$=0;}

meal: START_MEAL list_of_servings END_MEAL {$$=$2; printf("total in meal is %d \n",$2);}

list_of_servings: list_of_servings ',' serving {$$=$1+$3;}

list_of_servings: serving {$$=$1;}

serving:  VEGETABLE {$$=1;} | FRUIT {$$=2;} | MEAT {$$=4;} | BREAD {$$=3;} | DESSERT {yylval.desserts=1; printf("\n - here is lex dessert %f\n here is calories %d\n",yylval.desserts,yylval.food); $$=yylval.food;}

%%                     /* C code */


int main (void) {
	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

