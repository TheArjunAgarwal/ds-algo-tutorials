#import "../style.typ": *



#show: main.with(
  title: [Algorithm Design Paradigms],
  subtitle: [Handout on Dynamic Programming],
  date: datetime.today()
)

DP is such a rich topic that one could (and people do) spend whole careers working on it (and meanwhile resolving a lot of problems).

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

#exercise(title : "Substring")[
    Given two strings S & T, find the Longest Common Subsequence.
Let a subsequence of S is the result of deleting some(0 to All) characters in S.
E.g. S = “abcde”; “”, “abcde”, “ae” are the subsequences of S, but “aeb” is not.
Remind that Subsequence != Substring. (Substring is contiguous)
If S = “abcdef”, T = “ebbdaf”,
There Longest Common Subsequence = “bdf”
]

#exercise(title : "Subset Sum")[
  Given a list $A$ of $N$ integers, find a subset of integers that sums to $S$.
]