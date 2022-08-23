%option noyywrap

%{
    #include <stdio.h>
    int flag = 0;
%}

%%
[[a-z.0-9_]+@[a-z]+".com"|".in"]* {
    flag = 1;
}

%%

int main()
{
    printf("Enter the email: ");
    yylex();

    if(flag == 1)
    {
        printf("Valid email!\n");
    }
    else
    {
        printf("Invalid email!\n");
    }

    return 0;
}