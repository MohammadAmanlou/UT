#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int min_cost_path(vector<vector<int>> table) {
    int rows = table.size();
    int cols = table[0].size();
    vector<vector<int>> dpr(rows, vector<int>(cols));
    vector<vector<int>> dpl(rows, vector<int>(cols));
    dpr[0][0] = table[0][0];
    dpl[0][0] = table[0][0];

    for (int j = 1; j < cols; j++) {
        dpr[0][j] = dpr[0][j-1] + table[0][j];
        dpl[0][j] = dpl[0][j-1] + table[0][j];
    }

    for (int i = 1; i < rows; i++) {
        for (int j = cols-1; j >= 0; j--) {
            if (j == cols-1) {
                dpl[i][j] = table[i][j] + min(dpl[i-1][j], dpr[i-1][j]);
            } else {
                dpl[i][j] = table[i][j] + min({dpl[i-1][j], dpl[i][j+1], dpr[i-1][j]});
            }
        }
        
        for (int k = 0; k < cols; k++) {
            if (k == 0) {
                dpr[i][k] = table[i][k] + min(dpr[i-1][k], dpl[i-1][k]);
            } else {
                dpr[i][k] = table[i][k] + min({dpr[i-1][k], dpr[i][k-1], dpl[i-1][k]});
            }
        }
    }

    return dpr[rows-1][cols-1];
}

int main() {
    int n, m;
    cin >> n >> m;

    vector<vector<int>> table(n, vector<int>(m));
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            cin >> table[i][j];
        }
    }

    cout << min_cost_path(table) << endl;

    return 0;
}