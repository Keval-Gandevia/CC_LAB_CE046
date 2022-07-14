%option noyywrap
%s A B C D E DEAD
%{ 
    #include <stdio.h>    
%}

%%

<INITIAL>0 BEGIN B; 
<INITIAL>1 BEGIN A; 
<INITIAL>[^01\n] BEGIN DEAD; 
<INITIAL>\n BEGIN INITIAL; {printf("Not accepted...\n");}

<A>0 BEGIN B;
<A>1 BEGIN A;
<A>[^01\n] BEGIN DEAD; 
<A>\n BEGIN INITIAL; {printf("Accepted...\n");}

<B>1 BEGIN A;
<B>0 BEGIN D;
<B>[^01\n] BEGIN DEAD; 
<B>\n BEGIN INITIAL; {printf("Not accepted...\n");}

<C>0 BEGIN B;
<C>1 BEGIN A;
<C>[^01\n] BEGIN DEAD; 
<C>\n BEGIN INITIAL; {printf("Accepted...\n");}

<D>0 BEGIN D;
<D>1 BEGIN E;
<D>[^01\n] BEGIN DEAD; 
<D>\n BEGIN INITIAL; {printf("Not accepted...\n");}

<E>0 BEGIN D;
<E>1 BEGIN E;
<E>[^01\n] BEGIN DEAD; 
<E>\n BEGIN INITIAL; {printf("Not accepted...\n");}

<DEAD>[^\n] BEGIN DEAD; 
<DEAD>\n BEGIN INITIAL; {printf("Invalid...\n");}

%%

int main()
{
    yylex();
    return 0;
}