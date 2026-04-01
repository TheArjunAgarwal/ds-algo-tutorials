def solve(n):
    dp = [0.0] * (n + 1)
    
    dp[0] = 0
    if n >= 1:
        dp[1] = 1

    for x in range(2, n + 1):
        cur = 0
        for i in range(1, x + 1):
            ans = (
                1 / x
                + (i - 1) / x * (1 - dp[i - 1])
                + (x - i) / x * (1 - dp[x - i])
            )
            cur = max(cur, ans)
        dp[x] = cur

    return dp[n]


n = int(input())
print(solve(n))