M = int(input())

L = []
R = []

for _ in range(M):
    s, q = input().split()
    q = int(q)
    if s == "LEFT":
        L.append(q)
    else:
        R.append(q)

L.sort()
R.sort()

candidates = set(L + R)
ans = M  # worst case

for x in candidates:
    left_bad  = sum(1 for q in L if q < x)   
    right_bad = sum(1 for q in R if q > x)   
    ans = min(ans, left_bad + right_bad)

print(ans)