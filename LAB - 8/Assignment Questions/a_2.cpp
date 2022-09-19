#include <bits/stdc++.h>
using namespace std;

// global variable
char l;

// function definitions
void T();
void E();
void T_();
void E_();
void F();
void match(char c);

int main()
{
    l = getchar();
    E();
    if (l == '$')
    {
        cout << "Parsing is successful..." << endl;
    }
    return 0;
}

void E()
{
    T();
    E_();
}

void T()
{
    F();
    T_();
}

void E_()
{
    if (l == '+')
    {
        match('+');
        E();
        E_();
    }
    else if ('e')
    {
        match('e');
    }
}

void T_()
{
    if (l == '*')
    {
        match('*');
        T();
        T_();
    }
    else if (l == 'e')
    {
        match('e');
    }
}

void F()
{
    if (l == '(')
    {
        match('(');
        E();
        match(')');
    }
    else if (l == 'x')
    {
        match('x');
    }
}

void match(char c)
{
    if (l == c)
    {
        l = getchar();
    }
    else if (l == '$')
    {
        l = '$';
    }
    else
    {
        cout << "Error in parsing..." << endl;
        exit(0);
    }
}