#include<bits/stdc++.h>

using namespace std;

typedef long long ll;
typedef pair<int, int> pii;
typedef pair<ll, int> pli;

const ll INF=1e18+1e5;
const int mod=1e9+7;
const int MAXN=100010;

int n, m, k, majid, s, t, u, v, w;
int topol[MAXN], mark[MAXN], good[MAXN];
int dp1[MAXN], dp2[MAXN];
vector<pii> G[MAXN];
ll dist[MAXN];
priority_queue<pli, vector<pli>, greater<pli>> pq;

inline void relax(int v, ll d){
	if (d<dist[v]) pq.push({dist[v]=d, v});
}
void dijkstra(int src){
	memset(dist, 63, sizeof(dist));
	memset(mark, 0, sizeof(mark));
	relax(src, 0);
	k=0;
	while (pq.size()){
		int u = pq.top().second;
		pq.pop();
		if (mark[u]) continue ;
		mark[u]=1;
		topol[++k]=u;
		for (auto [v, w]:G[u]) relax(v, dist[u]+w);
	}
}
inline void fix(int &x){
	if (x>=mod) x-=mod;
}
inline bool is_ok(int u, int v, int w){ return dist[u]+w==dist[v];}

int main(){
	ios_base::sync_with_stdio(false); cin.tie(); cout.tie();
	cin>>n>>m;
	cin>>majid>>s>>t;
	while (m--){
		cin>>u>>v>>w;
		G[u].push_back({v, w});
		G[v].push_back({u, w});
	}
	dijkstra(s);
	if (dist[t]>INF){
		cout<<"-1\n";
		return 0;
	}
	dp1[s]=dp2[t]=1;
	for (int i=1; i<=k; i++){
		int u=topol[i];
		for (auto [v, w]:G[u])
			if (is_ok(u, v, w)) fix(dp1[v]+=dp1[u]), cerr<<u<<" "<<v<<"\n";
	}
	for (int i=k; i; i--){
		int u=topol[i];
		for (auto [v, w]:G[u])
			if (is_ok(u, v, w)) fix(dp2[u]+=dp2[v]);
	}
	for (int v=1; v<=n; v++) good[v] = (1ll*dp1[v]*dp2[v]%mod == dp1[t]);
	
	dijkstra(majid);
	ll ans=INF;
	for (int v=1; v<=n; v++) if (good[v]) ans=min(ans, dist[v]);
	if (ans>=INF) ans=-1;
	cout<<ans<<"\n";

	return 0;
}
/*

*/