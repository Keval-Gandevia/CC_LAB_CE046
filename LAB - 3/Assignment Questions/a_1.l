%option noyywrap
%s A B C D E DEAD

%{
    #include <stdio.h>
%}

%%
<INITIAL>\n BEGIN INITIAL; {printf("Not accepted...\n");}
<INITIAL>[^Aa] BEGIN INITIAL; 
<INITIAL>[Aa] BEGIN A; 
<INITIAL>[^A-Za-z] BEGIN DEAD;

<A>\n BEGIN INITIAL; {printf("Not accepted...\n");}
<A>[^Ee] BEGIN A; 
<A>[Ee] BEGIN B;
<INITIAL>[^A-Za-z] BEGIN DEAD;

<B>\n BEGIN INITIAL; {printf("Not accepted...\n");}
<B>[^Ii] BEGIN B; 
<B>[Ii] BEGIN C;
<INITIAL>[^A-Za-z] BEGIN DEAD;

<C>\n BEGIN INITIAL; {printf("Not accepted...\n");}
<C>[^Oo] BEGIN C; 
<C>[Oo] BEGIN D; 
<INITIAL>[^A-Za-z] BEGIN DEAD;

<D>\n BEGIN INITIAL; {printf("Not accepted...\n");}
<D>[^Uu] BEGIN D; 
<D>[Uu] BEGIN E; 
<INITIAL>[^A-Za-z] BEGIN DEAD;

<E>\n BEGIN INITIAL; {printf("Accepted...\n");}
<E>[A-Za-z] BEGIN E;

<DEAD>[^\n] BEGIN DEAD; 
<DEAD>\n BEGIN INITIAL; {printf("Invalid...\n");}
%%

int main()
{
    yylex();
    return 0;
}