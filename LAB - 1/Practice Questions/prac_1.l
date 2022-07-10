%option noyywrap

%{
    #include <stdio.h>
%}

%%
. ECHO;
%%

int main(void)
{
    yylex();
    return 0;
}