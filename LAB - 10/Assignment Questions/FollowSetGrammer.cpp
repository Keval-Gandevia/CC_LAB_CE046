#include <bits/stdc++.h>
using namespace std;

// function definitions
set<char> find_First(char start, map<char, vector<string>> &productions);
map<char, vector<string>> take_input(char &st);
map<char, set<char>> _First_(map<char, vector<string>> &grammer);
set<char> FOLLOW(map<char, vector<string>> &grammer, map<char, set<char>> &FOLLOW_ans, map<char, set<char>> &FIRST, char non_term, char &start);
map<char, set<char>> Find_Follow(map<char, vector<string>> &grammer, map<char, set<char>> &FIRST, char &start);

int main()
{
    char start;
    auto grammer = take_input(start);
    auto FIRST = _First_(grammer);

    auto FOLLOW = Find_Follow(grammer, FIRST, start);

    cout << "\nFollow Set of the grammer....." << endl;
    for (auto ch : FOLLOW)
    {
        cout << ch.first << "->";
        for (auto k : ch.second)
            cout << k << " ";
        cout << endl;
    }
    return 0;
}

set<char> FOLLOW(map<char, vector<string>> &grammer, map<char, set<char>> &FOLLOW_ans, map<char, set<char>> &FIRST, char non_term, char &start)
{

    if (start != non_term && FOLLOW_ans.count(non_term) > 0)
    {
        return FOLLOW_ans[non_term];
    }

    if (start == non_term)
    {
        if (FOLLOW_ans[start].size() > 1)
        {
            return FOLLOW_ans[non_term];
        }
    }
    for (auto grm : grammer)
    {
        for (auto rule : grm.second)
        {
            if (rule == "^")
            {
                continue;
            }
            for (int i = 0; i < rule.length(); i++)
            {
                if (rule[i] == non_term)
                {
                    if (i == rule.length() - 1)
                    {
                        auto flw = FOLLOW(grammer, FOLLOW_ans, FIRST, grm.first, start);
                        for (auto ch : flw)
                        {
                            FOLLOW_ans[non_term].insert(ch);
                        }
                    }
                    else
                    {
                        if (!(rule[i + 1] >= 'A' && rule[i + 1] <= 'Z'))
                        {
                            FOLLOW_ans[non_term].insert(rule[i + 1]);
                            break;
                        }
                        else
                        {
                            bool ok = false;
                            for (int j = i + 1; j < rule.length(); j++)
                            {

                                if (rule[j] >= 'A' && rule[j] <= 'Z')
                                {
                                    for (auto ch : FIRST[rule[j]])
                                    {
                                        if (ch == '^')
                                        {
                                            ok = true;
                                        }
                                        FOLLOW_ans[non_term].insert(ch);
                                    }
                                    FOLLOW_ans[non_term].erase('^');
                                }
                                else
                                {
                                    FOLLOW_ans[non_term].insert(rule[j]);
                                    ok = false;
                                    break;
                                }
                            }
                            if (ok)
                            {
                                auto flw = FOLLOW(grammer, FOLLOW_ans, FIRST, grm.first, start);
                                for (auto ch : flw)
                                {
                                    FOLLOW_ans[non_term].insert(ch);
                                }
                            }
                            break;
                        }
                    }
                }
            }
        }
    }
    return FOLLOW_ans[non_term];
}

map<char, set<char>> Find_Follow(map<char, vector<string>> &grammer, map<char, set<char>> &FIRST, char &start)
{
    map<char, set<char>> FOLLOW_ans;
    FOLLOW_ans[start].insert('$');

    set<char> non_terminal;

    for (auto ch : grammer)
    {
        non_terminal.insert(ch.first);
    }

    for (auto non_term : non_terminal)
    {
        auto flw = FOLLOW(grammer, FOLLOW_ans, FIRST, non_term, start);
        for (auto ch : flw)
        {
            FOLLOW_ans[non_term].insert(ch);
        }
    }
    return FOLLOW_ans;
}

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

map<char, vector<string>> take_input(char &st)
{
    int number_of_prod;
    cout << "Enter the number of total production rules: ";
    cin >> number_of_prod;
    map<char, vector<string>> grammer;
    char Start_symbol = ' ';
    for (int i = 0; i < number_of_prod; i++)
    {
        char start;
        string rule;

        cout << "Enter the left side symbol: ";
        cin >> start;

        cout << "Enter the rule...." << endl;
        cin >> rule;

        if (Start_symbol == ' ')
        {
            Start_symbol = start;
        }
        grammer[start].push_back(rule);
    }
    st = Start_symbol;
    return grammer;
}

map<char, set<char>> _First_(map<char, vector<string>> &grammer)
{
    map<char, set<char>> FIRST;

    for (auto Non : grammer)
    {
        FIRST[Non.first] = find_First(Non.first, grammer);
    }
    return FIRST;
}