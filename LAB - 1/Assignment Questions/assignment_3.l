%option noyywrap

%{
    #include <stdio.h>
    #include <string.h>
    int a_count = 0;
    int an_count = 0;
    int the_count = 0;
%}

%%
[a-zA-Z]+ {if(strcmp(yytext, "a") == 0) a_count++;
            else if(strcmp(yytext, "an") == 0) an_count++;
            else if(strcmp(yytext, "the") == 0) the_count++;}
. ;
%%

int main(void)
{
    yylex();
    printf("Count of a: %d\n", a_count);
    printf("Count of an: %d\n", an_count);
    printf("Count of the: %d\n", the_count);

    return 0;
}