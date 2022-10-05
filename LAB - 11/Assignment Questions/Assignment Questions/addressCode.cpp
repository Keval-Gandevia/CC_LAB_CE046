#include <bits/stdc++.h>
using namespace std;

int precedence(char ch);
string three_address_code(string infix);
void printOutput(string s);


int main()
{
    string infix;
    cout << "Enter the infix expression: ";
    cin >> infix;

    string res = three_address_code(infix);
    printOutput(res);

    return 0;
}

// function that generate three address code
string three_address_code(string infix)
{
    stack<char> s;

    // push $ to identify the end of the stack
    s.push('$');
    string res = "";

    for(auto it = infix.begin(); it != infix.end(); it++)
    {
        // if char is alphabet or numeric push it into the stack
        if (isalnum(char(*it)))
        {
            res += *it;
        }
        else if (*it == ')')
        {
            while(s.top() != '$' && s.top() != '(')
            {
                res += s.top();
                s.pop();
            }
            s.pop();
        }
        else if(*it == '(')
        {
            s.push('(');
        }
        else
        {
            if (precedence(*it) > precedence(s.top()))
            {
                s.push(*it);
            }
            else
            {
                while (s.top() != '$' && precedence(*it) <= precedence(s.top()))
                {
                    res += s.top();
                    s.pop();
                }
                s.push(*it);
            }
        }
    }   

    while (s.top() != '$')
    {
        res += s.top();
        s.pop();
    }

    return res;
}

void printOutput(string res)
{
    vector<vector<char>> output;
    int count = 1;
    stack<char> s;
    for (auto i : res)
    {
        if (i >= 'a' && i <= 'z')
        {
            s.push(i);
        }
        else
        {
            char op1 = s.top();
            s.pop();
            char op2 = s.top();
            s.pop();
            vector<char> v = {i, op1, op2, char('0' + count)};
            output.push_back(v);
            s.push('0' + count);
            count++;
        }
    }
    cout << setw(5) << "\nOperator Operand1  Operand2  Result" << endl;
    for (auto row : output)
    {
        cout << setw(5) << row[0] << setw(9) << row[2] << setw(10) << row[1] << setw(8) << row[3];
        cout << endl;
    }
}

// return the precedence of the operator.
int precedence(char ch)
{
    if (ch == '+' || ch == '-')
    {
        return 1;
    }
    else if (ch == '*' || ch == '/')
    {
        return 2;
    }
    else if (ch == '^')
    {
        return 3;
    }
    
    return 0;
}