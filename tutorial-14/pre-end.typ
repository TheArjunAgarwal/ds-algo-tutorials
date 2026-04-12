#import "../style.typ": *

#show: main.with(
  title: [Algorithmic Design Techniques],
  subtitle: [What Your Endsem Could Look Like...],
  date: datetime.today(),
  report-style : false
)

// #set heading(numbering: (..x) => numbering("1.", ..x.pos().map(n => n - 1)))

#show raw : it => {
  set text(font : "Fira Code")
  it
}

#quote(attribution: "Frida Kahlo")[
  And in the end, I believe that we don't need to do anything to be loved. We spend our lives trying to seem prettier, smarter. But I realized two things. Those who love us see us with their hearts and attribute qualities to us beyond those we really have. And those who don't want to love us will never be satisfied with all our efforts. 
]

THIS IS NOT A MOCK! THIS IS NOT A PREDICTION! IF ANYTHING, IT IS FOR PREPARATION PURPOSE ONLY.

QUESTIONS ARE SOMEWHAT HARDER THAN WHAT CAN BE EXPECTED BUT THEN AGAIN, 1. BETTER SAFE THAN SORRY 2. YOU NEED TO ATTEMPT ONLY HALF THE PAPER.

 This exam has 5 questions for a total of 500 marks, of which you can score at most 250 marks. You may answer any subset of questions or parts of questions. All answers will be evaluated. Go through all the questions once before you start writing your answers.
 
 You may use the following functions, and assume in your analysis that they work correctly with the stated worst-case running times: 
 - `LENGTH(A)`: returns the length $n$ of array $A$, and runs in $O(n)$ time
 - `MERGESORT(A)`: returns the version of integer array $A$ which is sorted in non-decreasing order, and runs in $O(n log n)$ time when $A$ has $n$ elements; 
 - `BINARYSBARCH(A, v)`: returns the index of integer element $v$ in a sorted array $A$, or `NIL` if $v$ is not present in $A$. Runs in $O(log n)$ time when $A$ has $n$ elements. 
  
You may freely invoke functions that you have written as part of a different answer in the same answer sheet. You do not have to use loop invariants while proving the correctness of algorithms; but you must correctly explain why each loop (if there are some) does what you expect it to do. 

Clearly describe the meaning of any syntax that you use. E.g., if you use the notation `A[i:j]` to denote a sub-array, clearly explain what you mean by this. And similarly for any other notation. You may assume the following when analyzing the running time of algorithms: (i) comparing a pair of numbers takes constant time; (ii) reading/writing an array element using its index takes constant time, and, (iii) creating a new array, and returning an array, each takes time linear in the length of the array. You must clearly state any other assumption that you make.

You may use the Master Theorem for solving recurrences (except when the question says otherwise), but you must properly state the version of the theorem that you use, before applying it. 

Unstated assumptions and lack of clarity in solutions can and will be used against you during evaluation. You may freely refer to statements from the lectures in your arguments. You don't need to reprove these unless the question explicitly asks you to, but you must be precise.

#pagebreak()

+ 
  Given a $m$, `count_poly(m)` counts the number of polynomials $P$ with coefficients from ${0,1,dots,9}$ such that $P(3) = m$.

    #align(center)[
    #table(
      columns: 2,
      [*Input*], [*Output*],
      [m = 1], [1],
      [m = 3], 
      [2], 
      [m = 10], 
      [4]
    )
  ]

  *Hint:* Notice that there are no negative coefficients in $P$.

  (a) Write psudocode implementing `count_poly(m)` in $O(m log_3(m))$ time. #h(1fr) *(50 Marks)*

  (b) Argue the correctness of your implementation. #h(1fr) *(30 Marks)*

+ 
  CWI has bought a new vending machine. Unfortunately, as CWI got a 'bargain' on it, the machine is also faulty. It has space for $N$ items (1 indexed). However, when item $i$ is dispensed; item $1, 2, dots, i-1$ are dispensed for free. If there are no snacks of some of the types $1, 2, dots, i-1$, simply no snack of this type is dispensed. Buying snack of type $i$ is possible only if at least one snack of this type is available.
  
  Prof. Wupendra Wulkarni wants to abuse the machine. The function `optimal_value(C, Q, k)` takes as input an (1-indexed) array $C$ of length $N$ where $C[i]$ is the cost of the $i$-th item, array $Q$ of length $N$ where $Q[i]$ is the quantity of the $i$-th item and $k$, the amount of money Prof. Wulkarni wishes to spend; and returns the maximum worth of items he could obtain.

  For example, $k = 8$, $C = [7, 2, 3, 5, 7, 2]$ and $Q = [1, 3, 0, 3, 2, 1]$. We buy a snack of type 6; the vending machine also dispenses one snack of each of the types 1, 2, 4 and 5. We buy a snack of type 4; in addition to this snack, the vending machine dispenses one snack of type 2. So for a total value of $30$.

  (a) Write psudo-code implementing `optimal_value` in $O(N k)$ #h(1fr) *(60 Marks)*

  (b) Argue the correctness of your implementation. #h(1fr) *(40 Marks)*

+
  Given two $n times n$ matrices $A$ and $B$, `magic_function(A,B)` allows us to compute their product $A B$ in time $O(n^(log_2 7)) approx O(n^(2.81))$
  
  (a) Assuming $m>= n$, can you find an $O(m^2 n^(0.81))$ algorithm to multiply $A$, a $m times n$ matrix, and $B$, a $n times m$ matrix, using the above function. *Hint:* Multiply $ceil(m/n)^2$ pairs of order-n matrices.
  
  #h(1fr) *(40 Marks)*
  
  (b) Assuming $m >= n >= t$, Can you find an $O(m n t^(0.81))$ algorithm to multiply $A$, a $m times n$ matrix, and $B$, a $n times t$ matrix, using the above function. *Hint:* Multiply pairs of $t times t$ matrices.
  
  #h(1fr) *(40 Marks)*

+
  Kitty and Min-Ho are trying to plan the perfect date across Seoul.

  Let Seoul be a $m times n$ grid with all important sites on the intersections. The cuteness of a site at the intersection of line $i$ and line $j$ is $C[i][j]$.

  It takes $|i_1 - i_2| + |j_1 - j_2|$ to travel from $(i_1, j_1)$ to $(i_2, j_2)$. Visiting a site takes unit time.

  As Kitty and Minho love each others company, they gain one cuteness for every unit time they spend traveling.

  Also, things should get more legendary as the date progresses. So they cuteness of a site visited later can't be less than one visited earlier.

  Kitty and Minho have some $t$ units of time before Kitty's flight back home. They start at $(0,0)$, the location of KISS or Korean Independent School of Seoul, which provides no cuteness.
  
  (a) Write the complete psudocode for a recursive algorithm `max_cute_tour(C, t)` that given the cutness table, returns the maximum cuteness a tour can obtain in time $t$. #h(1fr) *(40 Marks)*

  (b) In terms of $m, n, t$, What is the runtime of your recursive solution? #h(1fr) *(20 Marks)*

  (c) Write the psudocode for the memoized version of your algorithm from part (a) without using any libraries or decorators or language features.#h(1fr) *(30 Marks)*

  (d) Modify your psudocode from part (c) and now output the tour achieving maximum cuteness.
  
  #h(1fr) *(30 Marks)*

+ 
  Master Tengen has sensed a massive surge in cursed energy across the $n$ districts of Japan. To maintain the peace, the two rival schools: Tokyo Jujutsu High and Kyoto Jujutsu High, have both requested permission to station sorcerers across the country.
  
  There are $n$ districts in Japan, some of which are connected by high-speed transit routes. To ensure every citizen is safe from Curses, each school (Tokyo and Kyoto) insists that for every single district:
  - The district must have a Sorcerer Station from their school, *OR*
  - The district must be directly connected to another district that has one.
  
  Master Tengen, however, is wary of the intense rivalry between the two schools. He fears that if a single district hosts stations from both Tokyo and Kyoto, the clashing Cursed Energy will resonate, accidentally birthing a Special Grade Disaster Curse.

  See an example below. Red is Tokyo and Blue is Kyoto.

  #figure(image("p2_example.png", height: 20%))

  (a) As a practicioner of the Algorithms Jutsu, you are requested to provide a psudo-code implementing a function `deployment_plan(G)` that takes the graph with vertices representing the cities of Japan and edges representing connection by a high-speed transit; provides a deployment plan (an array $D$ such that $D[i]$ is $0$ if no one is deployed there, $1$ if Tokyo High is deployed there and $2$ if Kyoto high is deployed there) for the sorcerers of the two schools if possible or returns `NO` if it is not possible. #h(1fr) *(70 Marks)*

  (b) Argue that your algorithm runs in $O(|V| + |E|) = O(n + binom(n,2)) = O(n^2)$ time. #h(1fr) *(25 Marks)*

  (c) Argue the correctness of your algorithm. #h(1fr) *(25 Marks)*