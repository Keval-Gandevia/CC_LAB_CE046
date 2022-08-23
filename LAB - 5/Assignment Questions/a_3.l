%option noyywrap

%{
    #include <stdio.h>
    int i, num1 = -1, num2 = -1;

    int symbolToValue(char c)
    {
        if (c == 'I')
        {
            return 1;
        }
        if (c == 'V')
        {
            return 5;
        }
        if (c == 'X')
        {
            return 10;
        }
        if (c == 'L')
        {
            return 50;
        }
        if (c == 'C')
        {
            return 100;
        }
        if (c == 'D')
        {
            return 500;
        }
        if (c == 'M')
        {
            return 1000;
        }
        return -1;
    }

    int romanToDecimal()
    {
        int ans = 0, max = -1;
        for(i = 0; i < yyleng; i++)
        {
            int value = symbolToValue(yytext[i]);

            if(max == -1)
            {
                ans += value;
                max = value;
            }
            else if(max < value)
            {
                ans = value - ans;
                max = value;
            }
            else
            {
                ans += value;
            }
        }
        return ans;
    }
%}

%%
[IVXLCDM]* {
    
    if(num1 == -1)
    {
        num1 = romanToDecimal();
        printf("Equivalent of %s is %d.\n", yytext, num1);
    }
    else if(num2 == -1)
    {
        num2 = romanToDecimal();
        printf("Equivalent of %s is %d.\n", yytext, num2);
        printf("Addition is = %d", num1 + num2);
    }
}

%%

int main()
{
    printf("Enter 2 roman numbers: ");
    yylex();
    return 0;
}