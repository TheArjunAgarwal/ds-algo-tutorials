#import "../style.typ": *

#show: main.with(
  title: [Algorithm Design Paradigms],
  subtitle: [Handout on Induction],
  date: datetime.today()
)

#quote(attribution: "Anonymous")[
  The rise of nonchalance is the death of passion
]

= Induction

#defn(title:"Principle of mathematical induction")[
  Suppose we have an infinite sequence of statements $phi_0,phi_1, phi_2, phi_3, . . . $\
  and we can prove the following 2 statements -
  - $phi_0$ is true
  - $"For each "n" > 0, if "phi_(n-1)" is true, then "phi_(n)" is also true."$
  then all the statements $phi_0,phi_1, phi_2, phi_3, . . . $ in the sequence are true.
]

The above definition should be read as follows, given a sequence of formulas:
- The first one is true.
- Any formula being true, implies that the next one in the sequence is true.
Then all of the formulas in the sequence are true. Something like a chain of dominoes falling.

#exercise[Show that $n^2$ is the same as the sum of first $n$ odd numbers using induction.]

#exercise(title: "The scenic way")[
   (a) Prove the following theorem of Nicomachus by induction:
$
1^3 = 1\
2^3 = 3 + 5\
3^3 = 7 + 9 + 11\
4^3 = 13 + 15 + 17 + 19 \
.\
.\
.\
$ 
(b) Use this result to prove the remarkable formula
$
  1^3 + 2^3 + dots + n^3 = (1+2+dots+n)^2
$ 
]

#exercise(title: "Same Height?")[
Here is a proof by induction that all people have the same height. We prove that for any positive integer $n$, any group of $n$ people all have the same height. This is clearly true for $n = 1$. Now assume it for $n$, and suppose we have a group of $n + 1$ persons, say $P_1, P_2,dots, P_(n+1)$. By the induction hypothesis, the $n$ people $P_1, P_2, dots, P_n$ all have the same height. Similarly the $n$ people $P_2, P_3, dots, P_(n+1)$ all have the same height. Both groups of people contain $P_2, P_3, dots, P_n$, so $P_1$ and $P_(n+1)$ have the same height as $P_2, P_3, dots, P_n$. Thus all of $P_1, P_2,dots, P_(n+1)$ have the same height. Hence by induction, for any $n$ any group of $n$ people have the same height. Letting $n$ be the total number of people in the world, we conclude that all people have the same height. Is there a flaw in this argument?
]

#exercise(title: "There is enough information!")[
  Given $a_0 = 100$ and $a_n = - a_(n-1) - a_(n-2)$, what is $a_2025$?
]

#exercise(title: "2-3 Color Theorem")[
  A k-coloring is said to exist if the regions the plane is divided off in can be colored with $k$ colors in such a way that no two regions sharing some length of border are the same color.
  
  (a) A finite number of circles (possibly intersecting and touching) are drawn on a paper. Prove that a valid 2-coloring of the regions divided off by the circles exists.

  (b) A circle and a chord of that circle are drawn in a plane. Then a second circle
and chord of that circle are added. Repeating this process, until there are n
circles with chords drawn, prove that a valid 3-coloring of the regions in the plane divided off by
the circles and chords exists.
]

#exercise(title:"Square-full")[
  Call an integer square-full if each of its prime factors occurs to a second power (at least). Prove that there are infinitely many pairs of consecutive square-fulls.

  Hint: We recommend using induction. Given $(a,a+1)$ are square-full, can we generate another?
]

#exercise(title:"Proving the principle of induction")[
  Prove that the following statements are equivalent - \
  - every nonempty subset of $NN$ has a smallest element
  - the definition of induction
  You can assume that $<$ is a linear order on $NN$ with $n-1 < n$\ and such that there are no elements strictly between $n - 1$ and $n$.
]
