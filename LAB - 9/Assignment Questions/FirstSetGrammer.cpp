#include <bits/stdc++.h>
using namespace std;

set<char> find_First(char start, map<char, vector<string>> &productions)
{
    set<char> answer;
    bool epsilon = false;
    for (auto i : productions[start])
    {
        if (i == "^")
        {
            epsilon = true;
        }
    }

    for (auto k : productions[start])
    {
        for (int i = 0; i < k.size(); i++)
        {
            char ch = k[i];

            // if lower case
            if (!(ch >= 'A' && ch <= 'Z'))
            {
                answer.insert(ch);
                break;
            }
            // if upper case
            else if (ch >= 'A' && ch <= 'Z')
            {
                auto set_non_terminal = find_First(ch, productions);
                for (auto set_ch : set_non_terminal)
                {
                    answer.insert(set_ch);
                }

                // erase epsilon from set if it contains
                if (set_non_terminal.find('^') != set_non_terminal.end() && i != k.size() - 1)
                {
                    answer.erase('^');
                }
                // if it is end of the production do not erase epsilon
                else if (set_non_terminal.find('^') == set_non_terminal.end())
                {
                    break;
                }
            }
            // if epsilon
            else if (ch == '^')
            {
                answer.insert(ch);
            }
        }
    }

    return answer;
}

int main()
{
    int no_of_productions;
    cout << "Enter the number of total production rules: ";
    cin >> no_of_productions;

    map<char, vector<string>> productions;
    for (int i = 0; i < no_of_productions; i++)
    {
        char start;
        string rule;
        cout << "Enter the left side symbol: ";
        cin >> start;

        cout << "Enter the rule...." << endl;
        cin >> rule;
        productions[start].push_back(rule);
    }

    map<char, set<char>> FIRST;
    for (auto non_terminal : productions)
    {
        FIRST[non_terminal.first] = find_First(non_terminal.first, productions);
    }

    cout << "\nFirst Set of the grammer....." << endl;
    for (auto k : FIRST)
    {
        cout << k.first << "-> ";
        for (auto l : k.second)
        {
            cout << l << ", ";
        }
        cout << endl;
    }
}