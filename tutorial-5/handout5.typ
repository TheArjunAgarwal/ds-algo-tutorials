#import "../style.typ": *



#show: main.with(
  title: [Algorithm Design Paradigms],
  subtitle: [Handout on Geometric DnC],
  date: datetime.today()
)
#quote(attribution: "Yanis Varoufakis (Talking to My Daughter About the Economy)")[
  As a teacher of economics, I have always believed that if you are not able to explain the economy in a language young people can understand, then, quite simply, you are clueless yourself. #footnote[This is a lovely book which everyone should read.]
]

= Recap
You might have already seen *Merge Sort* and *Quick Sort* in the class. You probably also saw *Quick Select* (or median finding). Let's look at the psudo-code for these just to come to the same page.

#psudo(title: "Merge Sort")[
  + def MSORT(list):
    + L = left half of list
    + R = rest of the list
    + return MERGE(MSORT(L), MSORT(R))
  + def MERGE(as, bs):
    + if (empty as):
      + return bs
    + elif (empty bs):
      + return as
    + else:
      + if as[0] <= bs[0]:
        + a[0] : MERGE(tail as, bs)
      + else:
        + b[0] : MERGE(as, tail bs)
]
Remember, as primarily a Haskell person, my psudo code borrows some stuff from Haskell. In this case, `x:xs` is a stand in for `append(x, xs)` and `tail xs` refers to `a[1..]`.

The time complexity comes from the recursion $T(n) = 2 T(n/2) + O(n) => T(n) = O(n log n)$.

Correctness is proven in 2 steps:
+ Prove that given 2 sorted lists `as, bs`, `MERGE as bs` is sorted by induction
+ Prove the correctness of Merge Sort by induction.

#psudo(title : "Quick Sort")[
  + def QSORT(list):
    + pivot = random element from list
    + L = items less or equal to pivot in the (list - pivot)
    + R = items greater than the pivot in (list - pivot)
    + return QSORT(L) ++ [pivot] ++ QSORT(R)
]

Here the correctness follows swiftly via induction. However, the time complexity is not that clear.

In the worst case scenario, we could keep splitting the list into a length $0$ and a length $n-1$ list. $T(n) = T(0) + T(n-1) + O(n) => T(n) = O(n^2)$.

Then why are we interested in Quick Sort? The reason is, that it has expected time complexity of $O(n log n)$.

#proof(title:"Wrong Proof")[
  Notice,
  $
  T(n) = T(L) + T(R) + O(n) "where L, R are lengths of left and right lists"\
  => EE(T(N)) = EE(T(L) + T(R) + O(n)) = EE(T(L)) + EE(T(RR)) + EE(O(n)) "by linearity of expectation"\
  = EE(T(L)) + EE(T(R)) + O(n)\
  = T(EE(L)) + T(EE(R)) + O(n)\
  = T(n/2) + T(n/2) + O(n)\
  => EE(T(L)) = O(n log n) 
  $
]

What is the error here?#footnote[This is a very, very common erroneous proof. It won't be hard to find DSA books with this kind of an error]

The actual way we prove this is as follows:
#proof[
Notice, our time complexity here is just the number of times we compare elements.

Consider the list we are sorting a permutation of $[x_1, x_2, dots , x_n]$. Let $X_(i,j)$ be a random variable which is $1$ if the $x_i$ and $x_j$ are compared and $0$ otherwise. Let $p_(i,j)$ be the  probability that $x_i$ and $x_j$ are compared. Then, $EE(X_(i,j)) = 1 * p + 0 * (1-p) = p$.

Using the linearity of expectation, we can say $EE(T(n)) = sum_(i, j) EE(X_(i,j)) = sum_(i,j) p_(i,j)$.

We rewrite this summation as
$
  EE(T(n)) &= sum_(i,j) p_(i,j)\
  &= sum_(i=1)^n sum_(j=i+1)^n p_(i,j)\
$
Despite a toothy appearance, this is rather easy and elegant way to actually compute $p_(i,j)$.\

Notice that each element in the array (except the pivot) is compared only to the pivot at each level of the recurrence. To compute $p_(i,j)$, 
we shift our focus to the elements $[x_i, x_(i+1), dots, x_j]$. If this is split into two parts, $x_i$ and $x_j$ can no longer be compared.
Hence, $x_i$ and $x_j$ are compared only when from the first pivot from the range $[x_i, x_(i+1), dots, x_j]$ is either $x_i$ or $x_j$.

This clearly has probability $p_(i,j) = 1/(j-i+1) + 1/(j-i+1) = 2/(j-i+1)$. Thus,
$
  EE(T(n)) &= sum_(i=1)^n sum_(j=i+1)^n 2/(j-i+1)\
  &= sum_(i=1)^n 2 (1/2 + dots + 1/(n-i+1))\
  &= 2 sum_(i=1)^n (1 + 1/2 + dots + 1/(n-i+1) - 1)\
  &<= sum_(i = 1)^n O(log(n))\
  &<= O(n log(n))
$
And we are done.
]

Remember, $bold(EE(T(n)) != T(EE(n)))$ in general. We can't willy nilly switch symbols around and hope it works out.

Finally,
#psudo(title: "Quick Select")[
  + def QSELECT(arr, k):
    + n = LENGTH(arr)
    + pivot = choose random element of arr
    + L = items less or equal to pivot in the (list - pivot)
    + R = items greater than the pivot in (list - pivot)
    + l = LENGTH(L)
    + if l == k-1:
      + return pivot
    + elif l < k-1:
      + return QSELECT(R, k - l - 1)
    + else:
      + return QSELECT(L, k)
]
Again, the worst case time complexity is quite easy to judge:
$
T(n) = T(n-1) + T(0) + O(n)\
=> T(n) = O(n^2)
$

But if we redo the above analysis for expected time complexity we would get (other than lots of pain) is that the expected time complexity is $O(n)$.

However, given that there is a chance of our $O(n)$ algorithm running in $O(n^2)$, we can try to choose a better pivot.

#psudo(title:"Better Pivot")[
  + def PIVOT(arr):
    + a1, a2, a3, a4, a5 = array's of size $(|"arr"|)/5$
    + m1, m2, m3, m4, m5 = median of a1, a2, a3, a4, a5
    + \/\/ _This is a comment!_
    + \/\/ _We find median via MSELECT which we will define below_
    + return (median [m_1, m_2, m_3, m_4, m_5])
  + def MSELECT(arr, k):
    + n = LENGTH(arr)
    + pivot = PIVOT(arr)
    + L = items less or equal to pivot in the (list - pivot)
    + R = items greater than the pivot in (list - pivot)
    + l = LENGTH(L)
    + if l == k-1:
      + return pivot
    + elif l < k-1:
      + return QSELECT(R, k - l - 1)
    + else:
      + return QSELECT(L, k)
]

We can show that our scheme chooses a pivot such that $(3n)/10 < L, R < (7n)/10$.

The time complexity hence is
$
T(n) <= T((7n)/10) + 5 T(n/5) + O(n)
$
And that is literally the recurrence I started the class with.

The goal of this rather lengthy recap was to convince you *Quick* implies easy to code and prove the correctness of but the time complexity is a nightmare; while in case of *Merge*, while we have to work to code and show correctness, the time complexity is normally a cakewalk.

= Closest Point
#problem[
Given $n$  points on the plane. Each point $p_i$  is defined by its coordinates  $(x_i,y_i)$ . We want to find among them two such points, such that the (Euclidean) distance between them is minimal.
]
There is an obvious $O(n^2)$ solution. We will use divide and contour to find a $O(n log n)$ solution.

#idea[
  Given our goal is $O(n log(n))$, we can sort our points (to begin with) without any extra cost
]
Let's sort our points by lexicographically.

Once we sort our points, we can draw a vertical line $l$ at some $x$ such that the points are split in left and right halves, $L$ and $R$.

Let's say we find the minimum distance $d_L$ and $d_R$ in the halves. We now want a way to combine. Notice, the obvious idea doesn't work as we $T(n) = 2 T(n/2) + O(n/2 * n/2)$ is $O(n^2)$.

We make the following observation, if $d = min(d_L, d_R)$ then if there are points across the partition that are closer than $d$, they must be within $d$ of the partition.

This restricts our search to a strip of width $2 d$ centered at $l$. But unfortunately, this is not enough as a lot of points could be here.

We make a similar observation about the $y$-axis now. For a point in this strip, if it's distance is less than $d$, then the difference in $y$ coordinates can't be more than $d$.

This implies that for each point in the strip, we only check in a $2 d times d$ rectangle around it. While it may not seem like it, we are done. Why?

By the fact that no two points in $L$ are closer than $d$ and similarly for $R$, we can have atmost $8$ points in such a rectangle.

This implies, $T(n) < 2 T(n/2) + 8 n + O(n) = 2 T(n/2) + O(n) => T(n) = O(n log n)$.

And we are done!

#psudo(title: "Nearest Points")[
  + def CLOSEST(points):
    + n = LENGTH(points)
    + if n <= 3:
      + return BRUTE_FORCE(points)
    + mid = n / 2
    + L = left half of points
    + R = right half of points
    + d_L = CLOSEST(L)
    + d_R = CLOSEST(R)
    + d = min(d_L, d_R)
    + strip = points whose x-distance from mid-line <= d
    + strip = strip sorted by y-coordinate
    + return min(d, STRIP_CLOSEST(strip, d))

  + def STRIP_CLOSEST(strip, d):
    + m = LENGTH(strip)
    + min_d = d
    + for i = 0 to m-1:
      + for j = i+1 to m-1:
        + if strip[j].y - strip[i].y >= min_d:
          + break
        + min_d = min(min_d, DIST(strip[i], strip[j]))
    + return min_d

  + def BRUTE_FORCE(points):
    + min_d = infinity
    + for i = 0 to LENGTH(points)-1:
      + for j = i+1 to LENGTH(points)-1:
        + min_d = min(min_d, DIST(points[i], points[j]))
    + return min_d
]

Notice that while the design and implementation of the algorithm took some work, the analysis was a freebie.


What is the "Quick" version of this? The idea is to divide the space of points into squares of some side $d$ and brute force the comparison of points in a square and points in neighboring squares.

If we had $k$ squares and each square had some $n_i$ points such that $sum_(i = 1)^k n_i = n$; then the number of comparisons is:
$
sum_(i = 1)^k (n_i^2 + sum_(j in N(i)) n_i n_j)\
<& sum_(i = 1)^k (n_i^2 + sum_(j in N(i)) max (n_i, n_j)^2)\
<& sum_(i=1)^k 9 n_i^2 quad "as every cell can have atmost 8 neighbors"\
=& 9 sum_(i=1)^k n_i^2\
=& Theta(sum_(i=1)^k n_i^2)
$

Notice, if our $d$ is close to the actual smallest distance, then the algorithm is linear time. Although, how do we guess this?

Similar to Quick Select, we make an approximate guess. Here, one way of doing so is by choosing some random $sqrt(n)$ points and take their shortest distance (by brute force).

#psudo(title: "Quick Nearest Points")[
+ def QUICK_DIST(points):
  + n = LENGTH(points)
  + if n <= 3:
    + return BRUTE_FORCE(points)
  + sample_size = CEIL(sqrt(n))
  + S = RANDOM_SAMPLE(points, sample_size)
  + d = BRUTE_FORCE(S)
  + grid = EMPTY_HASH_MAP
  + cell_size = d
  + for each p in points:
    + cx = FLOOR(p.x / cell_size)
    + cy = FLOOR(p.y / cell_size)
    + INSERT p INTO grid[(cx, cy)]
    + min_d = d
    + for each cell (cx, cy) in grid:
      + C = grid[(cx, cy)]
      + for each point p in C:
        + for dx = -1 to 1:
          + for dy = -1 to 1:
            + if (cx + dx, cy + dy) EXISTS in grid:
              + for each point q in grid[(cx + dx, cy + dy)]:
                + if p != q:
                  + min_d = min(min_d, DIST(p, q))
  + return min_d

+ def BRUTE_FORCE(points):
  + min_d = infinity
  + for i = 0 to LENGTH(points)-1:
    + for j = i+1 to LENGTH(points)-1:
      + min_d = min(min_d, DIST(points[i], points[j]))
  + return min_d
]

#proof[
  Notice, we atmost consider the points $2$ diagonals away from points. Consider $0 < x, y < s$ (we will later take the limit of $s -> oo$).
  
  This tells that, given some $d$, we make atmost:
  $
  (s/d)^2 ((8pi d^2)/s^2 n)^2\
  = s^2/d^2 (64 pi^2 d^4)/s^4 n^2\
  = (64 pi^2 d^2)/s^2 n^2
  $
  Now notice, $d = EE("minimum distance of" sqrt(n) "random points in a square of side" s)$.

  We will use $EE(X) = int_(0)^(oo) PP(X > x) dif x $ for a positive support varable $X$ to get a crude upper bound on $d$.

  Notice, if we already have put some $k$ points on the disk, the odds of the next point being atleast $x$ away is atmost $
  1 - k pi/4 ((x/2)^2)/s^2\
  = 1 - (k pi x^2)/(16 s^2)
  $
  This comes from putting a disk of radius $x/2$  at each of the previous points. These disks can't overlap, and at least a quarter of each disk is inside the square.

  We can now integrate
  $
  EE(X) &< int_(0)^(sqrt(2)) product_(i = 0)^(sqrt(n) - 1) (1 - (k pi x^2)/(16 s^2))  dif x\
  &< int_(0)^(sqrt(2)) product_(i = 0)^(sqrt(n) - 1) (1 - ( pi x^2)/(16 s^2))^k  dif x\
  &< int_(0)^(sqrt(2)) (1 - ( pi x^2)/(16 s^2))^((sqrt(n) (sqrt(n) - 1))/2)  dif x
  $
  Now Mathematica evaluates this integral as $(2 sqrt(2) s)/sqrt(n)$.

  We can plug this in to get the expected time complexity as $512 pi^2 n = Theta(n)$.
]
#remark[
  The bounds used are very, very blunt. In practice, the constant in my testing were close to 10.

  The choice to use these bounds was made as these are the 'easiest'. Bounding it better would require more probability (trick|theo)ry than I am comfortable introducing.
]

= Convex Hull
Another example of a famous divide and conquer algorithm is convex hull.
#problem[
  Finding the smallest convex polygon that encloses a given set of 2D points
] 
A simple approach probably would be thinking of this as wrapping a gift. Start at the right most, bottom point $p_1$ (which will definitely be on the hull) and then check other points to see if a $p_1 p_i$ is such that all points will be to one side of the line, if yes; then add $p_i$ to the hull and continue onwards.

This is perhaps the first example of output dependent algorithm you'll see. We make $O(n)$ comparisons every iteration and we have $h$ iterations where $h$ is the number of points on the hull. This makes the complexity $O(n h)$.

We can prove (with lots of difficulty, see On the Expected Complexity of Random Convex Hulls) that $EE(h) ~ O(n^(1/3))$ and hence, we have the expected complexity of Gift Wrapping as $O(n^(4/3))$.

Note: The worst case is $O(n^2)$ as we could have all the $n$ vertices on the same polygon.

What about a MergeHull algorithm? We can divide the points arbitrarily and make two hulls. Now how do we merge?  