%option noyywrap
%{
%}

%%
(00|11)[0-1]*(00|11) printf("Accepted!");
.* printf("Not Accepted!");
%%

int main(void)
{
    yylex();
    return 0;
}