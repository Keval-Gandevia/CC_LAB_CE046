%{
    #include <stdio.h>
    int var = 0;
%}

%%
[a-z]+ {ECHO;}
%%

int yywrap()
{
    yyin = fopen("data.txt", "r+");
    char ch = fgetc(yyin);
    while(ch != EOF)
    {
        printf("%c", ch);
        ch = fgetc(yyin);
    }   
    fclose(yyin);
    return var++;
}

int main()
{
    yylex();
    return 0;
}