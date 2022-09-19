#include <bits/stdc++.h>
using namespace std;

// global variable
char l;

// function definitions
void EP();
void E();
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
    if (l == 'i')
    {
        match('i');
        EP();
    }
}

void EP()
{
    if (l == '+')
    {
        match('+');
        match('i');
        EP();
    }
    else if (l == 'e')
    {
        match('e');
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
        cout << "Error in pasing..." << endl;
        exit(0);
    }
}