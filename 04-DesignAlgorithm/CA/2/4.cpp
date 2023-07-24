#include<bits/stdc++.h>

using namespace std;

const int MAXN=5010;

int n;
int A[MAXN];

int Solve(int tl, int tr, int h){
	if (tr-tl==0) return 0;
	int mid=min_element(A+tl, A+tr)-A;
	return min(Solve(tl, mid, A[mid]) + Solve(mid+1, tr, A[mid]) + A[mid]-h, tr-tl);
}

int main(){
	ios_base::sync_with_stdio(false); cin.tie(); cout.tie();
	cin>>n;
	for (int i=1; i<=n; i++) cin>>A[i];
	cout<<Solve(1, n+1, 0)<<"\n";

	return 0;
}
/*

*/