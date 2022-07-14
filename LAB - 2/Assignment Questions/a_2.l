%option noyywrap
%s A B C DEAD
%{ 
    #include <stdio.h>    
%}

%%

<INITIAL>1 BEGIN A; 
<INITIAL>0 BEGIN B; 
<INITIAL>[^01\n] BEGIN DEAD; 
<INITIAL>\n BEGIN INITIAL; {printf("Not accepted...\n");}

<A>0 BEGIN C;
<A>1 BEGIN INITIAL;
<A>[^01\n] BEGIN DEAD; 
<A>\n BEGIN INITIAL; {printf("Not accepted...\n");}

<B>1 BEGIN C;
<B>0 BEGIN INITIAL;
<B>[^01\n] BEGIN DEAD; 
<B>\n BEGIN INITIAL; {printf("Accepted...\n");}

<C>0 BEGIN A;
<C>1 BEGIN B;
<C>[^01\n] BEGIN DEAD; 
<C>\n BEGIN INITIAL; {printf("Not accepted...\n");}

<DEAD>[^\n] BEGIN DEAD; 
<DEAD>\n BEGIN INITIAL; {printf("Invalid...\n");}

%%

int main()
{
    yylex();
    return 0;
}