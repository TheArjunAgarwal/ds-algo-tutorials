#import "../style.typ": *

#show: main.with(
  title: [Algorithmic Design Techniques],
  subtitle: [What Your Midsem Could Look Like...],
  date: datetime.today(),
  report-style : false
)

// #set heading(numbering: (..x) => numbering("1.", ..x.pos().map(n => n - 1)))

#show raw : it => {
  set text(font : "Fira Code")
  it
}

#quote(attribution: "John Green")[
  We’ll be okay. Not in the short run. And not in the long run, either. But in the medium run
]

THIS IS NOT A MOCK! THIS IS NOT A PREDICTION! IF ANYTHING, IT IS FOR PREPARATION PURPOSE ONLY.

QUESTIONS ARE SOMEWHAT HARDER THAN WHAT CAN BE EXPECTED BUT THEN AGAIN, 1. BETTER SAFE THAN SORRY 2. YOU NEED TO ATTEMPT ONLY HALF THE PAPER.

 This exam has 6 questions for a total of 500 marks, of which you can score at most 250 marks. You may answer any subset of questions or parts of questions. All answers will be evaluated. Go through all the questions once before you start writing your answers.
 
 Do not use hash functions or hash tables/maps in your solutions. All arrays in the questions are zero-indexed. If you wish to use one-indexing in your solutions, please state this explicitly in each such solution. You may split up the pseudocode for an algorithm into two or more functions, if you wish; you don't have to write the entire pseudocode for an algorithm as one function. 
 
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
  Unroll each of the following recurrences to come up with an estimate $f(n)$ that satisfies $T(n) = Theta(f(n))$.
  
  In each case, verify your estimate by induction. Note that this involves verifying _two_ asymptotic bounds for each part, for the _same_ function $f$.

  In each case, you may assume bounds of the form $T(n') <= c'$ and $T(n'') >= c''$ where $n', n'', c', c''$ are all fixed constants of your choice. That is, you may assume constant upper and lower bounds for inputs of up to some constant size.
  
  You will _not_ get the credit for either part if you use the Master Theorem (or some such) to get at the estimate.

  (a) $T(n) = 6 T(T/7) + 67$ #h(1fr) *(25 Marks)*
  
  (b) $T(n) = 2 T(n/2) + 5 n$ #h(1fr) *(25 Marks)*


+ 
  A heavy rain has swept through the Minaguri Forest, awakening dormant Mushi energy beneath the soil. Ginko has decided to take advantage of the rare rainfall and harvest spirit mushrooms (reishi) that bloom only in such conditions.

  Ginko knows a winding trail through the forest containing $N$ glades, each a sacred clearing where spirit mushrooms gather in abundance. Every two consecutive glades are equidistant, and it takes Ginko exactly 1 hour to walk between any pair of adjacent glades.

  Upon arriving at a glade, Ginko, very efficient in his craft, collects all the mushrooms there instantly. However, spirit mushrooms, fueled by Mushi energy, regrow in exactly 2 hours after being harvested.

  Given the initial number of mushrooms in each glade as an array $G$ and the total duration of Ginko's walk in hours $t$, given Ginko walk starts at $G[0]$ but can end his walk at any glade along the trail, and may travel in either direction or stop and wait at a glade; write function `max_mushi(G,t)` which reports the maximum Mushi Ginko can collect given he takes the optimal path in $O(min (n, t))$ time.

  #align(center)[
    #table(
      columns: 3,
      [*Input*], [*Output*], [*Explanation*],
      [G = [3,4,3,5,1]\ t = 4], [18], 
      [$3 -> 4 -> 3 -> 5 -> 3$],
      [G = [4,4,1,1,5,5]\ t = 7], 
      [32], 
      [$4 -> 4 -> dots -> 4$],
      [G = [3]\
      t = 4],
      [12], 
      [We just stand at the Glade.]
    )
  ]
  *Hint* : Consider the case when $t >> n$. What do we do then? Can we generalize?

  (a) Write pseudocode implementing `max_mushi(G,t)` in $O(min(n, t))$ time. #h(1fr) *(80 marks)*

  (b) Prove the correctness of your implementation. #h(1fr) *(20 Marks)*




+ 
    To celebrate the end of midsems, a group of students head to the CLAB to play Deadshot.io. There are $n$ players participating, and the $i$th player has a skill score of $A[i]$. 

  They want to split into two teams for a match. They agree to the following rules:

  - Team Kabir must have a total skill score greater than or equal to Team Piyush.
  - The difference between the total skill scores of the two teams should be as small as possible.

  Write a function `balanced_teams(A)` that returns the minimum possible difference between the total skill scores of Team Kabir and Team Piyush under these rules in $O(n 2^(n/2))$ time.

  #align(center)[
    #table(
      columns: 3,
      [*Input*], [*Output*], [*Explanation*],
      [A = [5,4,7,6]], [0], 
      [Team Kabir gets 5 + 6 = 11 and \ Team Piyush gets 4 + 7 = 11 skill.],
      [A = [10, 1, 1]], 
      [8], 
      [Team Kabir gets 10 skill \ Team Piyush gets 1 + 1 = 2 skill.],
      [A = [3,4,2,2]], 
      [1], 
      [Team Kabir gets 4 + 2 = 6 skill \ and Team Piyush gets 3 + 2 = 5 skill.]
    )
  ]
  *Hint*: The intended solution uses $O(2^(n/2))$ space as we need *two* arrays of that length...( This should ring some bells)

  (a) Write pseudocode implementing `balanced_teams(A)`. You are not allowed to import libraries or use any language specific features. #h(1fr) *(60 Marks)*

  (b) Show that the time complexity is indeed $O(2^(n/2))$. #h(1fr) *(20 Marks)*

  (c) Prove the correctness of your implementation. #h(1fr) *(20 Marks)*

+ 
  CMI is sending the entire DS batch to a Sunidhi Chauhan concert to celebrate placements. Unfortunately, the stage is too high and the tickets too cheap, so people need to be paired up so that one person lifts the other on their
  shoulders to see the stage.

  Since everyone in the DS batch works out, any person can lift any other person.
  A minimum height of $h$ is needed to see the stage. When one person lifts
  another, their combined height is the sum of their individual heights.

  Given the heights of the batch in an array $H$, pair up the batch members to
  maximize the number of people who can see the stage, subject to the following:

  - A *pair* consists of exactly two people: both  of them see the stage if their combined height $>= h$ (by alternating or something).
  - A person standing *alone* (unpaired) can see the stage only if their
    height alone $>= h$. A person standing alone whose height $< h$
    does not count.
  - Every person must either be in exactly one pair or stand alone no one is left out.

  (a) Write the psudocode for an algorithm `can_see_concert(H, h)` that tells the maximum people who can see the concert that runs in $O(n log n)$ time. #h(1fr) *(35 Marks)*

  (b) Prove the correctness and time complexity. #h(1fr) *(15 Marks)*

+ 
  Prof Wupendra Wulkarni has come up with a new ritual for consuming his morning coffee. He fills his cup with half black coffee and half milk.

  He then chooses a $n$-length ceremonial word made up of only 'C' and 'M'. Now for $i = 1, 2, dots, n$ the following action is performed, if the $i$-th letter of the word is 
  - $C$: Then he drinks half the cup and fills it to the top with coffee.
  - $M$: Then he drinks half the cup and fills it to the top with milk.

  Prof. Wupendra is wondering, given the word, what did he drink more of, coffee or milk; or equal?
    
  (a) Write psudocode for an $O(n)$ time and $O(1)$ space algorithm `milk_or_coffee(str)` that determines if Prof. Wulkarni drank more coffee or milk. #h(1fr) *(60 Marks)*

  (b) Prove the correctness of your algorithm. #h(1fr) *(40 Marks)*

  *Warning:* Do not even think about using floating point. Floating point errors stack and up and we can easily create inputs to get the answer to be wrong!

  *Hint:* Here are some examples. See if you can see pattern...
    #align(center)[
    #table(
      columns: 2,
      [*Input*], [*Output*],
      ["C"], [Equal],
      ["M"], [Equal],
      ["MM"], [Milk],
      ["CM"], [Coffee],
      ["CMC"], [Coffee],
      ["MCMC"], [Milk],
      ["CMMC"], [Coffee],
      ["MCCCM"], [Coffee],
      ["MCCCMM"], [Milk],
      ["CCMMMC"], [Coffee],
      ["CCMMCM"], [Coffee],
      ["CCMCMM"], [Milk],
    )
  ]

+ 
  Ace has been captured by Blackbeard and is held prisoner aboard the Saber of Xebec, a massive ship with $n$ cabins. Blackbeard is demanding a hefty ransom.

  Nami, negotiating on behalf of the Straw Hats, agreed to the following terms. She will guess the cabin number where Ace is held. If she guesses correctly, Blackbeard releases Ace immediately. Otherwise, if her guess is too high, Blackbeard informs her of this and she pays him $a$ Berries. If her guess is too low, she pays $b$ Berries.

  (a) Write the complete psudocode for a recursive algorithm `search_price(n, a, b)` that computes the minimum cost Nami can incur in this search by using the optimal strategy, irrespective of where Ace is imprisoned. #h(1fr) *(50 Marks)*

  (b) What is the time complexity of your recursive solution? #h(1fr) *(20 Marks)*

  (c) Write the psudocode for the memoized version of your algorithm from part (a) without using any libraries or decorators or language features. #h(1fr) *(30 Marks)*

  #footnote[
    - All Anime references were provided by Naman Maheshwari. Any errors should be reported to him.
    - A lot of questions are based on material from "Looking For A Challenge" which is a collection of Problems from University of Warsaw's Programming Contest
    - Prof. Wupendra Wulkarni is the evil twin of Prof. Upendra Kulkarni; the latter is one of my favorite profs at CMI. For more questions featuring Wupendra Wulkarni, contact me.
  ]