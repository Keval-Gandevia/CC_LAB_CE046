%option noyywrap
%s A B C D E DEAD
%{ 
    #include <stdio.h>    
%}

%%
[A-Za-z] {ECHO; printf("\n"); yymore();}
%%

int main()
{
    yylex();
    return 0;
}