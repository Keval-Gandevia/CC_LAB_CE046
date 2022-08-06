%option noyywrap

%{
    #include <stdio.h>
    int i, count_a = 0, count_b = 0, flag = 0;
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
        else
        {
            if(yytext[i] == 'a')
            {
                count_a++;
            }
            else if(yytext[i] == 'b')
            {
                count_b++;
            }
        }
    }

    if(count_a == count_b && flag == 1)
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