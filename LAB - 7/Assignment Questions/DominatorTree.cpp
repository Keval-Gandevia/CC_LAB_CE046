#include <bits/stdc++.h>
using namespace std;

// function definitions
void dominator_tree(map<int, vector<int>> graph, int no_of_nodes);
void print_map(map<int, vector<int>> m);
void print_vector(vector<int> v);
vector<int> intersection(vector<int> a, vector<int> b);
map<int, vector<int>> CalculateInitialOut(int no_of_nodes);
vector<int> CalculateIn(map<int, vector<int>> graph, map<int, vector<int>> out, int n);
void print_output(map<int, vector<int>> in, int no_of_nodes);

int main()
{
    int no_of_nodes;
    cout << "Enter total number of nodes: ";
    cin >> no_of_nodes;

    map<int, vector<int>> graph;

    cout << "Enter the element of the adjancency matrix....." << endl;

    for (int i = 0; i < no_of_nodes; i++)
    {
        for (int j = 0; j < no_of_nodes; j++)
        {
            int x;
            cin >> x;
            graph[i].push_back(x);
        }
    }

    // call dominator tree
    dominator_tree(graph, no_of_nodes);

    return 0;
}

// function to find the dominator tree
void dominator_tree(map<int, vector<int>> graph, int no_of_nodes)
{
    map<int, vector<int>> out = CalculateInitialOut(no_of_nodes);
    map<int, vector<int>> in;
    map<int, vector<int>> prev_in;
    map<int, vector<int>> prev_out = out;

    bool change = false;
    int count = 0;
    while (!change)
    {
        for (int i = 1; i < no_of_nodes; i++)
        {
            in[i] = CalculateIn(graph, out, i);
            vector<int> temp = in[i];
            temp.push_back(i);
            out[i] = temp;
        }

        // check for the first iteration
        if (count == 0)
        {
            prev_in = in;
            prev_out = out;
            count++;
            continue;
        }
        else
        {
            if (prev_in == in || prev_out == out)
            {
                change = true;
            }
            prev_in = in;
            prev_out = out;
            count++;
        }
    }

    // print the output
    print_output(in, no_of_nodes);
}

// function for printing the final output
void print_output(map<int, vector<int>> in, int no_of_nodes)
{
    map<int, vector<int>> res;
    vector<int> zeros(no_of_nodes, 0);

    for (int i = 0; i < no_of_nodes; i++)
    {
        res[i] = zeros;
    }

    for (auto it : in)
    {
        for (auto v : it.second)
        {
            res[it.first][v] = 1;
        }
    }

    cout << endl
         << "Generated dominator tree...." << endl
         << endl;
    print_map(res);
}

// function to calculate the 'in' set
vector<int> CalculateIn(map<int, vector<int>> graph, map<int, vector<int>> out, int n)
{
    vector<int> in, blocks;

    for (auto it : graph)
    {
        if (it.second[n] == 1)
        {
            blocks.push_back(it.first);
        }
    }

    if (blocks.size() == 1)
    {
        in = out[blocks[0]];
    }
    else
    {
        for (int i = 0; i < out[blocks[0]].size(); i++)
        {
            in.push_back(out[blocks[0]][i]);
        }
        for (int i = 1; i < blocks.size(); i++)
        {
            in = intersection(in, out[blocks[i]]);
        }
    }

    return in;
}

// function for calculating the initial 'out' set
map<int, vector<int>> CalculateInitialOut(int no_of_nodes)
{
    map<int, vector<int>> out;

    // push initial node into out
    out[0].push_back(0);

    // initialize the other block's out.
    for (int i = 1; i < no_of_nodes; i++)
    {
        for (int j = 0; j < no_of_nodes; j++)
        {
            out[i].push_back(j);
        }
    }
    // print_map(out);
    return out;
}

// function to find the intersection of 2 vectors
vector<int> intersection(vector<int> a, vector<int> b)
{
    vector<int> ans;

    for (auto n : a)
    {
        for (auto m : b)
        {
            if (n == m)
            {
                ans.push_back(n);
            }
        }
    }

    return ans;
}

void print_map(map<int, vector<int>> m)
{
    for (auto it : m)
    {
        cout << it.first << " -> ";
        for (auto v : it.second)
        {
            cout << v << " ";
        }
        cout << endl;
    }
}

void print_vector(vector<int> v)
{
    for (auto it : v)
    {
        cout << it << " ";
    }
    cout << endl;
}