def pot_of_gold(A):
    n = len(A)
    dp = [[-1] * (n + 1) for _ in range(n + 1)]
    return pot_of_gold_rec3(A, 0, n - 1, True)

# Solution 1 : 2D table (n x n), O(1) update
def pot_of_gold_rec1(A, i, j):
    if i == j:
        return A[i]
    if i > j:
        return 0
    # We can make the moves: 
    # (i+1, j) or (i, j-1)
    # Our opp could now move us to:
    ## (i+2, j) or (i+1, j-1)
    ## (i+1, j-1) or (i, j - 2)
    # Choose min of both the cases (opp choice) 
    # and the max between them (me choice)
    return max (
        A[i] + min (
            pot_of_gold_rec1(A, i+2, j), 
            pot_of_gold_rec1(A, i+1, j-1)
            ), 
        A[j] + min (
            pot_of_gold_rec1(A, i+1, j-1), 
            pot_of_gold_rec1(A, i, j-2)
            )
        )
    # We make 4 calls per recursion but only n/2 levels so hence, O(4^(n/2)) = O(2^n) (as we reduce our length by 2. Also, for recursion, pot_of_gold_rec1(A, i+1, j-1) counts twice as nothing is stored!)

def pot_of_gold_memo1(A, i, j, dp):
    if i > j:
        return 0
    if dp[i][j] != -1:
        return dp[i][j]
    if i == j:
        dp[i][j] = A[i]
    else:
        dp[i][j] = max(
            A[i] + min(
                pot_of_gold_memo1(A, i+2, j, dp),
                pot_of_gold_memo1(A, i+1, j-1, dp)
            ),
            A[j] + min(
                pot_of_gold_memo1(A, i+1, j-1, dp),
                pot_of_gold_memo1(A, i, j-2, dp)
            )
        )
    return dp[i][j]

# Solution 2 : 1D table (n), O(n) update
def pot_of_gold_rec2(A, i):
    ## I have no clue. I was told by atleast 3 people that such a solution exists but I have no clue.
    # I can see why it may exist but no clue how to make it exist...
    # AI is solving with some gap concept which I am not able to understand mainly as I am NOOB.
    return

# Solution 3: 3D table (n x n x 2), O(1) update
def pot_of_gold_rec3(A,i, j, turn):
    if i == j:
        return A[i]
    if i > j:
        return 0
    if turn:
        # It is my turn, I'll pick something so as to maximize my payout going forward!
        return max(A[i] + pot_of_gold_rec3(A, i+1, j, not turn), A[j] + pot_of_gold_rec3(A, i, j-1, not turn))
    else:
        # If it is my opponents turn, they'll pick whatever they need to minimize my payout going forward.
        return min(pot_of_gold_rec3(A, i+1, j, not turn), pot_of_gold_rec3(A, i, j-1, not turn))
    # This has complexity O(2^n) as we make 2 calls per level and have n levels in the recursion.