%option noyywrap
%{
%}

%%
00[0-1]*00 printf("Accepted!");
11[0-1]*11 printf("Accepted!");
.* printf("Not Accepted!");
%%

int main(void)
{
    yylex();
    return 0;
}