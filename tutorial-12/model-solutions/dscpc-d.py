M, P, Q = map(int, input().split())


r = [[0 for i in range(M+1)] for _ in range(4)]
r[0][0] = 1

def propagate(arr):
    for i in range(M + 1):
        if arr[i]:
            if i + P <= M: arr[i + P] = 1
            if i + Q <= M: arr[i + Q] = 1

propagate(r[0])


for i in range(M + 1):
    if r[0][i]:
        r[1][i // 2] = 1
        r[2][i // 3] = 1

propagate(r[1])
propagate(r[2])


for i in range(M + 1):
    if r[1][i]: r[3][i // 3] = 1
    if r[2][i]: r[3][i // 2] = 1

propagate(r[3])

reachable = [0 for i in range(M+1)]
for s in range(4):
    for i in range(M + 1):
        if r[s][i]: reachable[i] = 1

print(sum(1 for i in range(M + 1) if not reachable[i]))