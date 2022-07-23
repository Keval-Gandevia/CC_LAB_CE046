%option noyywrap

%{
    #include <stdio.h>
    #include <string.h>
    char word[] = "old";
    int old_count = 0;
%}

%%
[a-zA-Z]+ {
    if(strcmp(word, yytext) == 0)
    {
        old_count++;
        fprintf(yyout, "%s", "new");
    }
    else
    {
        fprintf(yyout, "%s", yytext);
    }
    fprintf(yyout, "%s", " ");
}
. ;
%%

int main()
{
    yyin = fopen("data.txt", "r+");
    yyout = fopen("output.txt", "w+");
    yylex();

    printf("Occurences of old is: %d\n", old_count);
    return 0;
}