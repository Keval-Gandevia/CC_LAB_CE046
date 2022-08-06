%option noyywrap

%{
    #include <stdio.h>
    int i, top = -1, flag = 0;
    char str[256];
    
    void push(char c)
    {
        str[++top] = c;
    }    
%}

%%
[\[\{\(\)\}\]]* {
    for(i = 0; i < yyleng; i++)
    {
        if(yytext[i] == '[' || yytext[i] == '{' || yytext[i] == '(')
        {
            push(yytext[i]);
        }
        else if(yytext[i] == ']' || yytext[i] == '}' || yytext[i] == ')')
        {
            if(str[top] == '[' && yytext[i] == ']')
            {
                top--;
            }
            else if(str[top] == '{' && yytext[i] == '}')
            {
                top--;
            }
            else if(str[top] == '(' && yytext[i] == ')')
            {
                top--;
            }
            else
            {
                printf("%s string is not balanced!!", yytext);
                flag = 1;
                break;
            }
        }
    }

    if(flag == 0)
    {
        printf("%s string is balanced!!", yytext);
    }
}
%%

int main()
{
    printf("Enter a string: ");
    yylex();
    return 0;
}