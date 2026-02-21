#import "../style.typ": *



#show: main.with(
  title: [Algorithm Design Paradigms],
  subtitle: [Handout on Asymptotics],
  date: datetime.today()
)
This handout concerns solving for Asymptotics.

+ $T(n) = T(sqrt(n)) + O(n)$
+ $T(n) = 6T(n/3) + O(n^2)$
+ $T(n) = 4T(n/5) + O(n)$
+ $T(n) = 3 T(sqrt(n)) + log(n)$

  In each of the following situations, indicate whether $f = O(g)$, or $g = O(f)$, or both (in which case $f = Theta(g)$) or neither (is that even possible?!) 
+ $f(n) = n log n$ and $g(n) = 10n log(10n)$.
+ $f(n) = n^(1.01)$ and $g(n) = n log^2 n$.
+ $f(n) = (log n)^(log n)$ and $g(n) = n/(log n)$
+ $f(n) = log(n!)$ and $g(n) = n log(n)$
+ For a given $k < n$, $f(n) = binom(n,k)$ and $g(n) = n^k$
+ $f(n) = n$ and $g(n) = n^(1+ sin n)$

  Assume that $T(n) = 1$ for $n < N$ for some suitable $N$.
+ $T(n) = sum_(i = 1)^(n-1) T(i) + 1$
+ $T(n) = T((7n)/10) + T(n/5) + O(n)$
+ $T(n) = T(log(n)) + n$
+ $T(n) = T(n - sqrt(n)) + 1$
+ $T(n) = T(n-1) + n^k$ for $k > 1$, $k$ is a natural number.