#include <bits/stdc++.h>
using namespace std;

// global variable
char l;

// function definitions
void S();
void S_();
void S__();
void match(char c);

int main()
{
    l = getchar();
    S();
    if (l == '$')
    {
        cout << "Parsing is successful..." << endl;
    }
    return 0;
}

void S()
{
    if (l == 'a')
    {
        match('a');
        S_();
    }
    else if (l == 'b')
    {
        match('b');
        S__();
    }
}

void S_()
{
    if (l == '$')
    {
        match('$');
        l = '$';
    }
    else
    {
        S();
        match('a');
    }
}

void S__()
{
    if (l == '$')
    {
        match('$');
        l = '$';
    }
    else
    {
        S();
        match('b');
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
        cout << "Error in parsing..." << endl;
        exit(0);
    }
}