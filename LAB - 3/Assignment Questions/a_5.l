%{
    #include <stdio.h>
    int var = 0;
    FILE *fp;
%}

%%
[A-Za-z0-9\n\t ]+ {
    yyin = fopen("data.txt", "w+");
    fprintf(yyin, "%s", yytext);
}
. ;
%%

int yywrap()
{
    fclose(yyin);
    fp = fopen("data.txt", "r+");
    yyout = fopen("output.txt", "w+");
    char c = fgetc(fp);
    while(c != EOF)
    {
        if(c >= 'a' && c <= 'z')
        {
            fputc((c - ('a' - 'A')), yyout);
        }
        else
        {
            fputc(c, yyout);
        }
        c = fgetc(yyin);
    }
    fclose(fp);
    fclose(yyout);
    return var++;
}


int main()
{
    yylex();
    return 0;
}