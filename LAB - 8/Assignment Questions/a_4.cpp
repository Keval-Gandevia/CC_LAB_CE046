#include <bits/stdc++.h>
using namespace std;

// global variable
char l;

// function definitions
void A();
void B();
void C();
void S();
void match(char c);

int main()
{
    l = getchar();
    S();
    if (l == '$')
    {
        cout << "Parsing is successful" << endl;
    }
    return 0;
}

void S()
{
    A();
    B();
    C();
}

void A()
{
    if (l == 'a')
    {
        match('a');
        A();
        match('b');
    }
    else
    {
        C();
    }
}

void B()
{
    if (l == 'c')
    {
        match('c');
        B();
    }
    else if (l == 'd')
    {
        match('d');
    }
}

void C()
{
    if (l == 'e')
    {
        match('e');
        C();
    }
    else if (l == 'f')
    {
        match('f');
    }
}

void match(char c)
{
    if (l == c)
    {
        l = getchar();
    }
    else
    {
        cout << "Error" << endl;
        exit(0);
    }
}
