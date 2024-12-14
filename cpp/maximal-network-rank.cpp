#include <vector>
#include <utility>
#include <unordered_set>

using namespace std;

int maximalNetworkRank(int n, vector<vector<int>>& roads) {
	vector <int> degree (n,0);
	unordered_set<long long> connected;

	for(auto &road : roads) {
		int a = road[0], b = road[1];
		degree[a]++;
		degree[b]++;

		long long key = (long long) a*n+b;
		connected.insert(key);
	}

	int max_rank = 0;
	for(int i = 0; i < n; i++) {
		for (int j=i+1; j<n; j++) {
			int rank = degree[i] + degree[j];

		if (connected.find((long long) i*n+j) != connected.end()) {
			rank--;
		}

		if (rank > max_rank) {
			max_rank = rank;
		}
	}
}

return max_rank;
}
