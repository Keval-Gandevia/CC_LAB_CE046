%option noyywrap

%{
    #include <stdio.h>
    int i, j, flag = 0, output = 1;
    char str[256];
    int top = -1;

    void push(char c)
    {
        str[++top] = c;
    }
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
            push(yytext[i]);
        }
        else if(flag == 1)
        {
            if(yytext[i] != str[top--])
            {
                output = 0;
                break;
            }
        }
    }
    if(output == 1)
    {
        printf("%s is palindrome!!", yytext);
    }
    else
    {
        printf("%s not a palindrome!!", yytext);
    }
}
%%



int main()
{
    printf("Enter a string: ");
    yylex();
    return 0;
}