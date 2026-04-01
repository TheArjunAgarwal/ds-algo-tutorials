def solve(n, arr):
    # Step 1: Count frequencies (Replacement for map<int, int>)
    counts_dict = {}
    for x in arr:
        counts_dict[x] = counts_dict.get(x, 0) + 1
    
    # Step 2: Extract frequencies and sort them
    # (Replacement for vector<int> cnts and sort())
    cnts = sorted(counts_dict.values())
    
    if not cnts:
        return 0
    
    ans = 0
    max_freq = cnts[-1]
    
    # Step 3: Iterate through possible starting values
    for i in range(1, max_freq + 1):
        pos = len(cnts) - 1
        cur = i
        res = cur
        
        # Check if we can form a sequence by halving the count requirement
        while cur % 2 == 0 and pos > 0:
            cur //= 2
            pos -= 1
            
            # If the current available frequency isn't enough, stop this sequence
            if cnts[pos] < cur:
                break
            res += cur
            
        if res > ans:
            ans = res
            
    return ans

n = int(input())
arr = [int(x) for x in input().split()]
print(solve(n, arr))