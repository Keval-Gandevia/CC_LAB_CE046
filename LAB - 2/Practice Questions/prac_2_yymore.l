%option noyywrap
%{
    #include <stdio.h>   
%}

%%
foobar {ECHO; yymore();}
textbook {printf("\n"); ECHO;}
%%

int main()
{
    yylex();
    return 0;
}