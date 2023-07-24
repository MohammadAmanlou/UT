#include <iostream>
#include <vector>
#include <string>
using namespace std;

#define STONE '#'
#define BAMBOO '*'
#define NO_PATH "No path found"
#define MAX_MIN_WAY 1000000

typedef struct location
{
    int x;
    int y;
} location;
typedef struct arrows
{
    int up;
    int down;
    int right;
    int left;
} arrows;

vector<vector<char>> load_data()
{
    vector<vector<char>> table;
    vector<char> temp;
    string land;
    while (cin >> land)
    {
        for (int i = 0; i < land.size(); i++)
        {
            temp.push_back(land[i]);
        }
        table.push_back(temp);
        temp.clear();
    }
    return table;
}

int check_left_way(int x, int y, vector<vector<char>> land)
{
    if (x <= 0)
    {
        return 0;
    }
    else if (land[y][x - 1] == STONE)
    {
        return 0;
    }
    else
    {
        return 1;
    }
}

int check_right_way(int x, int y, vector<vector<char>> land)
{
    if (x >= land[y].size() - 1)
    {
        return 0;
    }
    else if (land[y][x + 1] == STONE)
        {
            return 0;
        }
    else
    {
        return 1;
    }
}

int check_up_way(int x, int y, vector<vector<char>> land)
{
    if (y <= 0)
    {
        return 0;
    }
    else if (land[y - 1][x] == STONE)
        {
            return 0;
        }
    else
    {
        return 1;
    }
}

int check_down_way(int x, int y, vector<vector<char>> land)
{
    if (y >= land.size() - 1)
    {
        return 0;
    }
    else if (land[y + 1][x] == STONE)
        {
        return 0;
        }
    else
    {
        return 1;
    }
}

void solve(location panda, arrows arrow, vector<vector<char>> land , int *min_way , int level)
{
    if(level>*min_way)return;
    if (land[panda.y][panda.x] == BAMBOO)
    {
        //cout << level << endl;
        if (level < *min_way)
        {
            *min_way = level;
            return;
        }
    }
    if (arrow.up == 1 && check_up_way(panda.x, panda.y, land))
    {
        panda.y -= 1;
        solve(panda, arrow, land, min_way, level+1);
    }
    else if (arrow.down == 1 && check_down_way(panda.x, panda.y, land))
    {
        panda.y += 1;
        solve(panda, arrow, land, min_way, level+1);
    }
    else if (arrow.right == 1 && check_right_way(panda.x, panda.y, land))
    {
        panda.x += 1;
        solve(panda, arrow, land, min_way, level+1);
    }
    else if (arrow.left == 1 && check_left_way(panda.x, panda.y, land))
    {
        panda.x -= 1;
        solve(panda, arrow, land, min_way, level+1);
    }
    else if ((!check_left_way(panda.x, panda.y, land)) && (!check_right_way(panda.x, panda.y, land)) && (!check_down_way(panda.x, panda.y, land)) && (!check_up_way(panda.x, panda.y, land)))
    {
        return;
    }
    else if (arrow.up == 1 && !check_up_way(panda.x, panda.y, land))
    {
        if (check_left_way(panda.x, panda.y, land))
        {
            arrow.up =0 ;
            arrow.left=1;
            panda.x -= 1;
            solve(panda , arrow , land , min_way , level+1);
        }
        if (check_right_way(panda.x, panda.y, land))
        {
            arrow.up =0 ;
            arrow.right=1;
            panda.x += 1;
            solve(panda , arrow , land , min_way , level+1);
        }
    }
    else if (arrow.down == 1 && !check_down_way(panda.x, panda.y, land))
    {
        if (check_left_way(panda.x, panda.y, land))
        {
            arrow.down =0 ;
            arrow.left=1;
            panda.x -= 1;
            solve(panda , arrow , land , min_way , level+1);
        }
        if (check_right_way(panda.x, panda.y, land))
        {
            arrow.down =0 ;
            arrow.right=1;
            panda.x += 1;
            solve(panda , arrow , land , min_way , level+1);
        }
    }
    else if (arrow.right == 1 && !check_right_way(panda.x, panda.y, land))
    {
        if (check_up_way(panda.x, panda.y, land))
        {
            arrow.right =0 ;
            arrow.up=1;
            panda.y -= 1;
            solve(panda , arrow , land , min_way , level+1);
        }
        if (check_down_way(panda.x, panda.y, land))
        {
            arrow.right =0 ;
            arrow.down=1;
            panda.y += 1;
            solve(panda , arrow , land , min_way , level+1);
        }
    }
    else if (arrow.left == 1 && !check_left_way(panda.x, panda.y, land))
    {
        if (check_up_way(panda.x, panda.y, land))
        {
            arrow.left =0 ;
            arrow.up=1;
            panda.y -= 1;
            solve(panda , arrow , land , min_way , level+1);
        }
        if (check_down_way(panda.x, panda.y, land))
        {
            arrow.left =0 ;
            arrow.down=1;
            panda.y += 1;
            solve(panda , arrow , land , min_way , level+1);
        }
    }
}

int main()
{
    vector<vector<char>> land;
    vector<vector<int *>> backtracking_data;
    land = load_data();
    location panda;
    panda.x = 0;
    panda.y = 0;
    arrows start_arrow_1 = {0, 0, 1, 0};
    arrows start_arrow_2 = {0, 1, 0, 0};
    int min_way = MAX_MIN_WAY;
    solve(panda, start_arrow_1, land, &min_way, 1);
    solve(panda, start_arrow_2, land, &min_way, 1);
    if (min_way == MAX_MIN_WAY)
    {
        cout << NO_PATH;
    }
    else {
        cout << min_way-1;
    }
    return 0;
}
