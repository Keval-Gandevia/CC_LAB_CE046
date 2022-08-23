%option noyywrap

%{
    #include <stdio.h>
    int count_a = 0, count_b = 0, count_c, flag1 = 0, flag2 = 0, flag3 = 0, i;
%}

%%
[a-c]* {
    for(i = 0; i < yyleng; i++)
    {
        if(flag1 == 0 && yytext[i] == 'b')
        {
            count_b++;
            flag1 = 1;
        }
        else if(flag1 == 1 && flag2 == 0 && yytext[i] == 'c')
        {
            count_c++;
            flag2 == 1;
        }
        else if(flag1 == 1 && flag2 == 1 && yytext[i] == 'c')
        {
            count_c++;
        }
        else if(flag1 == 1 && flag2 == 0 && yytext[i] == 'b')
        {
            count_b++;
        }
        else if(flag1 == 0 && flag2 == 0 && yytext[i] == 'a')
        {
            count_a++;
        }
        else
        {
            printf("%s is not accepted by the language!", yytext);
            flag3 = 1;
            break;
        }
    }

    if(flag3 == 0)
    {
        if(count_a + count_b == count_c)
        {
            printf("%s is accepted by the language!", yytext);
        }
        else
        {
            printf("%s is not accepted by the language!", yytext);
        }
    }
    
}
%%

int main()
{
    printf("Enter the string: ");
    yylex();
    return 0;
}