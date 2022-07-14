%option noyywrap
%{
    #include<stdio.h>
%}

%%
foobar {ECHO; yyless(2);}
%%

int main()
{
    yylex();
    return 0;
}
