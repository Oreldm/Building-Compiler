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
"apple"					{return FRUIT;}
"chicken"					{return MEAT;}
"bread"					{return BREAD;}
"vanilla ice cream"				{return DESSERT;}
"chocolate ice cream"				{return DESSERT;}
"cake"				{return DESSERT;}
" \n\t"					{;} 

%%
int yywrap (void) {return 1;}

