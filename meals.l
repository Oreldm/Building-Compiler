%{
#include "meals.tab.h"
void yyerror (char *s);
int yylex();
%}
%%
"<meal>"				{return START_MEAL;}
"</meal>"				{return END_MEAL;}

"tomato"				{return VEGETABLE;}
"cucumber"				{return VEGETABLE;}
"lettuce"				{return VEGETABLE;}
broccoli



"apple"					{return FRUIT;}
"watermelon"			{return FRUIT;}
"strawberry"			{return FRUIT;}
"orange"				{return FRUIT;}

"chicken"				{return MEAT;}
"beef"					{return MEAT;}

"bread"					{return BREAD;}

"vanilla ice cream"		{return DESSERT;}
"chocolate ice cream"	{return DESSERT;}
"cake"					{yylval.food=5; return DESSERT;}

[,]     { return yytext[0]; }
[\t\n ]+ /* skip white space */
. { fprintf (stderr, "illegal  token: %c",  yytext[0]);  exit (1); }
%%
int yywrap (void) {return 1;}