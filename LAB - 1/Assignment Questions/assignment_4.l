%option noyywrap

%{
    #include<string.h>
    #include<stdio.h>
    int key = 3;
%}

%%
[A-Za-z]+ {for(int i = 0; i < strlen(yytext); i++)
            {
                if(yytext[i] >= 'a' && yytext[i] <= 'z')
                {
                    printf("%c",'a' + ((yytext[i] - 'a' + key) % 26));
                }
                else{
                    printf("%c",'A' + ((yytext[i] - 'A' + key) % 26));
                }
            };
        }
%%

int main(void)
{
    yylex();
    return 0;
}