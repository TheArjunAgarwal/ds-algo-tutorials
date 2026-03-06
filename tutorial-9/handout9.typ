#import "../style.typ": *



#show: main.with(
  title: [Algorithm Design Paradigms],
  subtitle: [Handout 9],
  date: datetime.today()
)
#quote(attribution: "")[]

= Quiz 2

#remark[
  If your quiz didn't go well, it is OK!

  DP is a famously tricky topic. To quote myself from the DP handout: "DP is such a rich topic that one could (and people do) spend whole careers working on it".

  If it is any consolation, most BSc and MSc CS people also would fail to solve the question (especially if this was their first exposure to it). Small errors like mixing $min$ or $max$ are pretty easy to make!
  
  At the end of the day, the quiz is quite immaterial with respect to your placements. Also the question asked famously has its origin in Google Interviews, so it is not as easy as one of us might say in passing.
]
== The 2 Solutions I was able to find
#problem[
  Let $G$ be an array of $n$ positive integers. In the pots-of-gold game, there are $n$ pots $P_0, P_1, dots, P_(n-1)$ lined up in a row, and pot $P_i$ contains $G[i]$ gold coins. Two players start with an empty bag each, and they take turns removing exactly one pot from either end of the remaining row. Each player adds the gold coins from the removed pot to their own bag. The game ends when no pots remain.
]
#psudo(title: [$N times N$ Solution])[
+ def pot_of_gold_rec1(A, i, j):
  + if i == j:
    + return A[i]
  + if i > j:
    + return 0
  + \# _We can make the moves:_ 
  + \# _(i+1, j) or (i, j-1)_
  + \# _Our opp could now move us to:_
  + \#\# _(i+2, j) or (i+1, j-1)_
  + \#\# _(i+1, j-1) or (i, j - 2)_
  + \# _Choose min of both the cases (opp choice)_
  + \# _and the max between them (me choice)_
  + return max (
    + A[i] + min (
      + pot_of_gold_rec1(A, i+2, j), 
      + pot_of_gold_rec1(A, i+1, j-1)
      + ), 
    + A[j] + min (
      + pot_of_gold_rec1(A, i+1, j-1), 
      + pot_of_gold_rec1(A, i, j-2)
      + )
    + )
  ]

Notice, we make 4 calls per recursion but only $n/2$ levels so hence, $O(4^(n/2)) = O(2^n)$ (as we reduce our length by 2)

#psudo(title : [$N times N times 2$ Solution])[
+ def pot_of_gold_rec3(A,i, j, turn):
  + if i == j:
    + return A[i]
  + if i > j:
    + return 0
  + if turn:
    + return max(
      + A[i] + pot_of_gold_rec3(A, i+1, j, not turn), 
      + A[j] + pot_of_gold_rec3(A, i, j-1, not turn)
      + )
  + else:
    + return min(
      + pot_of_gold_rec3(A, i+1, j, not turn),
      + pot_of_gold_rec3(A, i, j-1, not turn)
      + )
]

The idea is that: _if it is my turn, I'll pick something so as to maximize my payout going forward!_ and _if it is my opponents turn, they'll pick whatever they need to minimize my payout going forward._

== Similar Problem
I had almost included this in the handout... But then decided against it. I am not sure how to feel about that.

#problem[
There are $N$ barrels of wine stored in a narrow passage. Each year, you sell either the first or the last barrel.

The $i$-th wine has initial price $P[i]$, and sells for $k dot P[i]$ in the $k$-th year.

What is the maximum possible total profit?
]
There is obvious recursion idea
$
"profit"(i, j, t) = max(P[i] dot t + "profit"(i+1, j, t+1), P[j] dot t + "profit"(i, j-1, t+1))
$

This clearly takes $O(n^3)$ time as we make a table $O(n^3)$. We can make it a lot faster by storing $n = "len(P)"$:
$
"profit"(i, j) = max(P[i] dot (n - j + i) + "profit"(i+1, j), P[j] dot (n - j + i) + "profit"(i, j-1))
$

Although, we saw some similar problems. 
#problem(title: "Player 1 Wins? (P19, Problem Set 1, Discussed Tutorial 5)")[
  You are given an integer array `nums`. Two players take turns, with player 1 starting first. Both players start with score $0$.

  At each turn, the player takes one of the numbers from either end of the array (`nums[0]` or `nums[len(nums) - 1]`, reducing the array size by $1$. The player adds the chosen number to their score.

  The game ends when no elements remain.

  Return `true` if Player 1 can win. If scores are equal, Player 1 is still considered the winner. Assume both players play optimally.
]
We can solve this by considering the difference of scores of both the players.
$
"val"(i, j) = max ("nums"[i] - "val"(i+1, j), "nums"[j] - "val"(i, j-1))
$

If $"val"(0, "len"("nums") - 1) >= 0$, we return `True` and `False` else.

Note, we can recover `pot_of_gold` from this using the fact $P_1 + P_2 = "sum"("nums")$ and $P_1 - P_2 = "val"$.

#problem(title : "Calvin and Hobbes (Induction & Recursion Handout, Week 2)")[
  Calvin and Hobbes wish to divide 25 coins, of denominations $1, 2, 3, dots, 25$ kopeks.

  In each move, one of them chooses a coin, and the other player decides who must take it.
  
  - Calvin makes the initial choice.
  - In subsequent moves, the choice is made by the player currently having more kopeks.
  - In case of a tie, the same player who chose in the preceding move chooses again.

  After all coins are taken, the player with more kopeks wins.

Which player has a winning strategy?
]