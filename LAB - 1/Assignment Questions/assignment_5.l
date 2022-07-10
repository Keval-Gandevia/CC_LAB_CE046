%option noyywrap
%{
    #include<string.h>
    #include<stdio.h>
    int prev = -1;
%}
%%
[A-Za-z]+ {
    int flag = 0;
    for(int i = 0; i < strlen(yytext); i++)
            {
                int curchar;
                if(yytext[i] >= 'a' && yytext[i] <= 'z')
                {
                    curchar = yytext[i] - 'a';
                }
                else{
                    curchar = yytext[i] - 'A';
                }
                if(curchar > prev)
                {
                    prev = curchar;
                }
                else
                {
                    printf("%s is not accepted!", yytext);
                    flag = 1;
                    break;
                }
            };

            prev = -1;
            if(flag == 0)
            {
                printf("%s is accepted!", yytext);
            }
            }
%%
int main(void)
{
    yylex();
    return 0;
}