%option noyywrap

%{
%}

%%
[0-9]* printf("It is a digit..");
^[^0-9]|[0-9]*[a-zA-Z] printf("It is not a digit..");
. ;
%%

int main(void)
{
    yylex();
    return 0;
}