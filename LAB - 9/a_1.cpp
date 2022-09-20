#include <bits/stdc++.h>
using namespace std;
set<char> find_First(char st, map<char, vector<string>> &grammer)
{
    set<char> answer;
    bool epsilon = false;
    for (auto k : grammer[st])
    {
        if (k == "^")
            epsilon = true;
    }
    for (auto k : grammer[st])
    {
        for (int i = 0; i < k.size(); i++)
        {
            char ch = k[i];
            if (!(ch >= 'A' && ch <= 'Z'))
            {
                answer.insert(ch);
                break;
            }
            else if (ch >= 'A' && ch <= 'Z')
            {
                auto set_non = find_First(ch, grammer);
                for (auto set_ch : set_non)
                    answer.insert(set_ch);
                if (set_non.find('^') != set_non.end() && i != k.size() - 1)
                    answer.erase('^');
                else if (set_non.find('^') == set_non.end())
                    break;
            }
            else if (ch == '^')
                answer.insert(ch);
        }
    }
    return answer;
}
int main()
{
    int number_of_prod;
    cin >> number_of_prod;
    map<char, vector<string>> grammer;
    for (int i = 0; i < number_of_prod; i++)
    {
        char start;
        string rule;
        cin >> start;
        cin >> rule;
        grammer[start].push_back(rule);
    }
    map<char, set<char>> FIRST;
    for (auto Non : grammer)
    {
        FIRST[Non.first] = find_First(Non.first, grammer);
    }
    for (auto k : FIRST)
    {
        cout << k.first << " ";
        for (auto l : k.second)
            cout << l;
        cout << endl;
    }
}