%option noyywrap

%{
    #include <stdio.h>
    #include <ctype.h>
    #include <string.h>
    int arr[1000], top = -1, i;
    
    void push(int n)
    {
        arr[++top] = n;
    }

    int pop()
    {
        if(top == -1)
        {
            printf("Error!");
        }
        return arr[top--];
    }

    
%}

%%

[0-9\*\+\-\/]* {
    for(i = 0; i < strlen(yytext); i++)
    {
        if(isdigit(yytext[i]))
        {
            push(yytext[i] - '0');
        }
        else
        {
            int op1 = pop();
            int op2 = pop();

            if(yytext[i] == '+')
            {
                push(op1 + op2);
            }
            else if(yytext[i] == '-')
            {
                push(op1 - op2);
            }
            else if(yytext[i] == '*')
            {
                push(op1 * op2);
            }
            else if(yytext[i] == '/')
            {
                push(op1 / op2);
            }
        }
    }

    printf("Result is = %d\n", pop());
}

%%

int main()
{
    printf("Enter an expression: ");
    yylex();
    return 0;
}