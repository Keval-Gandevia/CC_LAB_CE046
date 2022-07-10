%option noyywrap

%{
    #include<stdio.h>
    int lines = 0, words = 0;
%}

%%
[^ \t\n]+      words++;
\n             {lines++; words++;}
%%

int main(){
    yyin = fopen("input.txt","r");
    yylex();
    printf("Lines: %d\n", lines);
    printf("Words: %d\n", words);
    return 0;
}