%option noyywrap
%s A B DEAD
%{ 
    #include <stdio.h>    
%}

%%
<INITIAL>1 BEGIN A; 
<INITIAL>0 BEGIN INITIAL; 
<INITIAL>[^01\n] BEGIN DEAD; 
<INITIAL>\n BEGIN INITIAL; {printf("Accepted...\n");} 

<A>1 BEGIN B;
<A>0 BEGIN INITIAL;
<A>[^01\n] BEGIN DEAD; 
<A>\n BEGIN INITIAL; {printf("Accepted...\n");}

<B>1 BEGIN B;
<B>0 BEGIN B;
<B>[^01\n] BEGIN DEAD; 
<B>\n BEGIN INITIAL; {printf("Not Accepted...\n");}

<DEAD>[^\n] BEGIN DEAD; 
<DEAD>\n BEGIN INITIAL; {printf("Invalid...\n");}
%%


int main()
{
    yylex();
    return 0;
}