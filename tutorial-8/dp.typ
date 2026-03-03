#import "../style.typ": *



#show: main.with(
  title: [Algorithm Design Paradigms],
  subtitle: [Handout on Dynamic Programming],
  date: datetime.today()
)

DP is such a rich topic that one could (and people do) spend whole careers working on it (and meanwhile resolving a lot of problems).

I will try to limit myself to simple stuff.

= Warm Up

#exercise(title : "Jumper")[
There $n$ building on a line and the height of $i$-th building is $h_i$.

There is a man who wants to go to building $n$ from building $1$ by jumping rooftop to rooftop.

He can jump really high and each jump cost him $|h_i - h_j|$ from $i$ to $j$.

But he can’t jump too far, so the gaps between building he can jump is
limited to $k$. That is. $j - i <= k$.

Also he can only jump forward.

Write an algorithm to figure out the minimum energy used in $O(n k)$.
]

= Classic

#exercise(title : "LCS")[
Given two strings $S$ and  $T$, find the Longest Common Subsequence.

Let a subsequence of $S$ is the result of deleting some(0 to All) characters in $S$.

E.g. $S = "\"abcde\""$; "", "abcde", "ae" are the subsequences of $S$, but "aeb" is not.

Reminder that Subsequence $!=$ Substring. (Substring is contiguous)

If $S = "\"abcdef\""$, $T = "\"ebbdaf\""$. Then there LCS is "bdf".
]

#exercise(title : "Max Sum")[
Let $A$ be an array of $n$ positive integers.
Consider function
$
f(k) = cases(0 "if" k = 0, max_(i=1)^k (A[i] + f(k-i)))
$

Compute $f$.
]

#exercise(title: "Rod Cutting")[
Given a rod of length $n$ and an array $P$ of length $n$ where $P[i]$ is the price for a rod of length $i$ sells for, for each $i in [1,n]$

Goal: Cut the rod into segments of integer lengths to maximize the revenue.
]

#exercise(title : "Edit Distance")[
Given two strings $A = a_1 a_2 dots a_m$ and $B = b_1 b_2 dots b_n$,

Compute Edit Distance aka the minimum number of operations to convert $A$ into $B$ where the allowed operations are:
- Insert a character
- Delete a character
- Substitute one character for another
]

#exercise(title : "Longest Increasing Subsequence")[
Given an array of integers $A[1 dots n]$, find the length of the longest strictly increasing
subsequence LIS.
]

#exercise(title : "Max Weight Subarray Again")[
Let $A$ be an array of $n$ integers ($A$ is not necessarily sorted). Each integer in $A$ may be positive or negative.

Given $i, j$ satisfying $1 <= i <= j <= n$,

Define sub-array $A[i : j]$ as the sequence $(A[i], A[i + 1], dots, A[j])$, and the weight of $A[i : j]$ as
$A[i] + A[i + 1] + dots + A[j]$. 

We already have an $O(n log n)$ algorithm for this. We now want to find an $O(n)$ algorithm using Dynamic Programming.
]

#exercise(title : "Subset Sum")[
  Given a list $A$ of $N$ integers, find a subset of integers that sums to $S$.
]

#exercise(title : "Knapsack")[
  Given a list $V$ of length $N$ of positive integers, a list $W$ of length $W$ of positive integers and capacity $C$; Choose a subset of $I$ of $[1,N]$ that maximizes:
  $
  sum_(i in I) V[i]
  $
  upto the constraint
  $
  sum_(i in I) W[i] <= C
  $
]



= Nice but not too hard
#exercise(title : "Longest Palindrome Sequence")[
  Given a string $S$ with length $N$. The target is to find the longest Palindrome Subsequence.

Here, Palindrome is a string $A$ such that the reverse of the $A$.

E.g. Longest Palindrome Subsequence of $"\"abcabca\""$ is $"\"abcba\""$.
]

#exercise(title : "Coin Change")[
  Given an unlimited supply of coins of denominations $x_1, x_2, dots , x_n$ , we wish to make change for a value $v$; that is, we wish to find a set of coins whose total value is $v$. Design an $O(n v)$ dynamic programming algorithm for solving this problem.
]

#exercise(title : "Password (ZIO 2025)")[
  You need to select a passcode consisting of $N$ numeric digits. Each digit can be between $0$ and $9$, both inclusive, and your passcode may have leading $0$s. Therefore, there are $10^N$ possible passcodes. Let $D_i$ denote the $i$th digit of your passcode (1 indexed).
  
  To make your passcode difficult to guess, you make sure that:
  - No two adjacent digits are equal. That is, for all $1 <= i <= N-1, D_i != D_(i+1)$.
 - For any three consecutive digits, they are not all increasing. That is, there must be no $1 <= i <= N-2$ such that $D_i < D_(i+1)$ and $D_(i+1) < D_(i+2)$.

- For any three consecutive digits, they are not all decreasing. That is, there must be no $1 <= i <= N-2$ such that $D_i > D_(i+1)$ and $D_(i+1) > D_(i+2)$.
- 
For a given length $N$, what is the number of passcodes you can create of that length?
]

#exercise(title : "Triangle Path (IOI P1, 1994)")[
```
    7
   3 8
  8 1 0
 2 7 4 4
4 5 2 6 5
```
Given above is a number triangle. Our question concerns such triangles. Write a program that calculates the highest sum of numbers passed on a route that starts at the top of a number triangle and ends somewhere on the base of the number triangle. Note: Each step can go either diagonally down to the left or diagonally down to the right.

For the example given above, the answer is $30$ via $7 -> 3 -> 8 -> 7 -> 5$.
]

#exercise(title : "Matrix Multiplication")[
  Let us assume for any two matrices $A$ and $B$ whose dimension are $m times n$ and $n times p$. We define the cost of multiplying $A$ and $B$ as $m n p$ (we know this is not the most efficient but for the sake of argument). Given $n$ matrices $A_1, dots , A_n$, where the $i$-th matrix has dimension $m_(i−1) times m_i$, Design an efficient algorithm for determining the minimum cost for multiplying all $n$ matrices. Note that multiplying the matrices in different orders might change the total cost.
]

#exercise(title: "Post Office (IOI P5, 2000")[
There is a straight highway with villages alongside the highway. The highway is represented as an integer axis, and the position of each village is identified with a single integer coordinate. There are no two villages in the same position. The distance between two positions is the absolute value of the difference of their integer coordinates.

Post offices will be built in some, but not necessarily all of the villages. A village and the post office in it have the same position. For building the post offices, their positions should be chosen so that the average distance from each village to its nearest post office is minimized.

You are to write a program which, given the positions of the villages and the number of post offices, computes the least possible sum of all distances between each village and its nearest post office, and the respective desired positions of the post offices.
]

#exercise(title : "Bag Of Mice (CF 148D)")[
Princess and Dragons take turns drawing a mouse from a bag which initially contains $w$ white and $b$ black mice. The person who is the first to draw a white mouse wins. After each mouse drawn by the dragon the rest of mice in the bag panic, and one of them jumps out of the bag itself (the princess draws her mice carefully and doesn't scare other mice). Princess draws first. What is the probability of the princess winning?

If there are no more mice in the bag and nobody has drawn a white mouse, the dragon wins. Mice which jump out of the bag themselves are not considered to be drawn (do not define the winner). Once a mouse has left the bag, it never returns to it. Every mouse is drawn from the bag with the same probability as every other one, and every mouse jumps out of the bag with the same probability as every other one.
]

#exercise(title : "Broken Robot (CF 24D)")[
  You received as a gift a very clever robot walking on a rectangular board. Unfortunately, you understood that it is broken and behaves rather strangely (randomly). The board consists of $N$ rows and $M$ columns of cells. The robot is initially at some cell on the $i$-th row and the $j$-th column. 
  
  Then at every step the robot could go to some another cell. The aim is to go to the bottommost ($N$-th) row. The robot can stay at it's current cell, move to the left, move to the right, or move to the cell below the current. If the robot is in the leftmost column it cannot move to the left, and if it is in the rightmost column it cannot move to the right. At every step all possible moves are equally probable. Return the expected number of step to reach the bottommost row.
]
