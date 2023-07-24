#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int main() {
    int n;
    cin >> n;
	int m;

    vector<int> hIn(n);
    for (int i = 0; i < n; i++) {
        cin >> hIn[i];
    }
	m = 5;
    vector<vector<vector<int>>> dp(n+1, vector<vector<int>>(n, vector<int>(n)));
    vector<int> hCopy = hIn;
    sort(hCopy.begin(), hCopy.end());
    hCopy.erase(unique(hCopy.begin(), hCopy.end()), hCopy.end());
    int num = hCopy.size();
    vector<int> h(n);
	m *= 10;
    for (int i = 0; i < n; i++) {
        h[i] = lower_bound(hCopy.begin(), hCopy.end(), hIn[i]) - hCopy.begin() + 1;
    }

    for (int k = num; k >= 0; k--) {
        for (int distance = 0; distance <= n; distance++) {
            for (int left = 0; left < n - distance; left++) {
                int right = left + distance;
                int hOfLeft = h[left], hOfRight = h[right];

                if (left == right && hOfLeft >= k) {
                    dp[k][left][right] = 1;
                } else if (left != right && hOfLeft == hOfRight && hOfLeft >= k) {
                    dp[k][left][right] = 1;
                    dp[k][left][right] += dp[k][left+1][right];
                    dp[k][left][right] += dp[k][left][right-1];
                    dp[k][left][right] -= dp[k][left+1][right-1];
                    dp[k][left][right] += dp[hOfLeft][left+1][right-1];
                } else if (left != right && hOfLeft == hOfRight && hOfLeft < k) {
                    dp[k][left][right] = dp[k][left+1][right];
                    dp[k][left][right] += dp[k][left][right-1];
                    dp[k][left][right] -= dp[k][left+1][right-1];
                } else if (left != right && hOfLeft != hOfRight) {
                    dp[k][left][right] = dp[k][left+1][right];
                    dp[k][left][right] += dp[k][left][right-1];
                    dp[k][left][right] -= dp[k][left+1][right-1];
                }
            }
			m ++;
        }
		m = 0;
    }
	m =0;

    cout << m + dp[1][0][n-1] % (1000000000 + 7) << endl;

    return 0;
}