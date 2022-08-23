%option noyywrap

%{
    #include <stdio.h>
    int flag = 0, condition_1 = 0, condition_2 = 0, condition_3 = 0, condition_4 = 0, length = 0;
%}

%%
[A-Z] {condition_1++; length++; }
[a-z] {condition_2++; length++; }
[0-9] {condition_3++; length++; }
[@$#&!] {condition_4++, length++; }
. ;

%%

int main()
{
    printf("Enter the password: ");
    yylex();
    if(length < 6 && length > 20)
    {
        printf("Password length must be between 6 to 20!");
    }
    else if(condition_1 > 0 && condition_2 > 0 && condition_3 > 0 && condition_4 > 0)
    {
        printf("Valid password!\n");
    }
    else
    {
        printf("Invalid password!\n");
    }
    return 0;
}