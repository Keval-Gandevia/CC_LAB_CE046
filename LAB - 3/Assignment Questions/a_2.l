%option noyywrap

%{
    #include <stdio.h>
    #include <math.h>
    int len, i, res = 0;
%}

%%
[0-1]+ {
    len = yyleng;
    for(i = 0; i < len; i++)
    {
        if(yytext[i] == '1')
        {
            res = res + pow((double)2, (double) len - i - 1);
        }
    } 
    printf("Decimal of %s is %d\n", yytext, res);
    res = 0;
}
. ;
%%

int main()
{
    yylex();
    return 0;
}