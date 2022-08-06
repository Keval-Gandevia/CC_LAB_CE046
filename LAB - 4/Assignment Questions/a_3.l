%option noyywrap

%{
    #include <stdio.h>
    int i, count = 0, flag = 0;
%}

%%
[a-c]* {
    for(i = 0; i < yyleng; i++)
    {
        if(yytext[i] == 'c')
        {   
            flag = 1;
            continue;
        }
        else if(flag == 0)
        {
            count++;
        }
        else if(flag == 1)
        {
            count--;
        }
    }

    if(count == 0)
    {
        printf("%s is accepted!!", yytext);
    }
    else
    {
        printf("%s is not accepted!!", yytext);
    }
}
%%

int main()
{
    printf("Enter a string: ");
    yylex();
    return 0;
}