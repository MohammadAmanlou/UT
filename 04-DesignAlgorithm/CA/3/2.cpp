#include<bits/stdc++.h>

using namespace std;

const int N=720;

int n, m, f, r, u;
int A[N][N];

int main(){
	ios_base::sync_with_stdio(false); cin.tie(); cout.tie();
	cin>>n;
	for (int i=0; i<n; i++)
		for (int j=0; j<n; j++)
			cin>>A[i][j];
	
	for (int k=0; k<n; k++)
		for (int i=0; i<n; i++)
			for (int j=0; j<n; j++)
				A[i][j]=min(A[i][j], A[i][k] + A[k][j]);
	
	cin>>m;
	while (m--){
		cin>>f>>r>>u;
		int res1 = A[f][r] + A[r][u];
		int res2 = res1 - A[f][u];
		cout<<res1<<" "<<res2<<"\n";
	}

	return 0;
}
/*

*/