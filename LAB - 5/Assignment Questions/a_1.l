%option noyywrap

%{
    #include <stdio.h>
    int count_a = 0, count_b = 0, flag = 0, flag1 = 0, i;
%}

%%
[a-b]* {
    for(i = 0; i < yyleng; i++)
    {
        if(yytext[i] == 'a' && flag == 1)
        {
            printf("%s is not accepted by the language!", yytext);
            flag1 = 1;
            break;
        }
        else if(flag == 0 && yytext[i] == 'b')
        {
            count_b++;
            flag = 1;
        }
        else if(yytext[i] == 'a')
        {
            count_a++;
        }
        else if(yytext[i] == 'b')
        {
            count_b++;
        }
    }

    if(flag1 == 0)
    {
        if((count_b * 2) == count_a)
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