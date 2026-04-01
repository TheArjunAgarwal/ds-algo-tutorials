n, M = map(int, input().split())
B = list(map(int, input().split()))
G = list(map(int, input().split()))   

best = {}
for j in range(1, n + 1):
    val = G[j - 1]
    if val not in best:
        best[val] = B[j - 1]
    else:
        best[val] = max(best[val], B[j - 1])

candidates = sorted(best.values(), reverse=True)
print(sum(candidates[:M]))