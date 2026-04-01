#import "../style.typ": *



#show: main.with(
title: [Algorithm Design Paradigms],
subtitle: [Handout on Greedy Algorithms],
date: datetime.today()
)
#quote(attribution: "")[]

= Some Old Friends

#exercise(title : "Concert")[
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
]

  #exercise(title: "Glinko's Walk", breakable : true)[
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
    [9], 
    [We just stand at the Glade.]
  )
]
]

One can notice quite a few similarities in our answers to both of these questions. Trying to articulate these similarities gives us the idea of a greedy algorithm.

Instead of dividing into subproblems and combining or storing the solution to smaller problems and using it to construct it; we are just making (locally optimal) a choice and never looking back. 

This might seem like a very myopic strategy but it surprisingly works on a lot of problems. As we will see, it is one of the things that is so simple and elegant that sometimes people (aka extremely accomplished researchers) simply forget it exists.

= Scheduling Problems

#problem[
  - There are $N$ events at a music festival. 
  - The $i^"th"$ event start at $S_i$ and end at $E_i$
  - For any two events, you can join both of them if and only if they do not overlap

We want to find a schedule to maximize the number of events you can attend.
]

Now while this is a greedy tutorial, for the sake of practice, can we all see a DP solution? Can we all see why it's not a very good solution?

Back to greedy, what could the strategy be? I can see 4 ways to ‘greedy’:
- Attend the event with smallest starting time
- Attend the event with smallest ending time
- Attend the event with smallest conflicts
- Attend the event with shortest interval

Only one of these works. Can you see a counter-example to the others?

The correct answer is to attend the event with smallest ending time. Join the one which ends earlier, this can help us reserve more time to join other events.

Another similar problem is called the Job Scheduling problem
#problem[
  - There are $N$ tasks you need to do.
  - Task $i$ takes $t_i$ hours
  - For every hour that passes until task $i$ is done, pay $c_i$

We want to minimize the cost in finishing the tasks.
]
For example, say the tasks you have are *finishing homework* and *sleeping* with $T = [10, 8]$ and $C = [2, 3]$.

Thus, if we do homework and then sleep, it costs us $10*2 + 18 * 3 = 74$ but if we sleep and then do homework it costs us $8 * 3 + 18 * 2 = 60$. Hence, the problem is well defined as the order does have something to do with the total cost.

Second thing to notice is that if $A -> B -> C -> D$ is the optimal job scheduling for $A, B, C, D$; then $B -> C -> D$ better be optimal for $B, C, D$ as otherwise rearranging it above would simply be optimal. This makes the structure of the problem look incredibly suspictible to greedy.

Let's say we have two jobs $a$ and $b$ with times $t_a, t_b$ and costs $c_a, c_b$. When is $a -> b$ cheaper than $b -> a$?
$
t_a c_a + (t_a + t_b) c_b <=& t_b c_b + (t_a + t_b) c_a\
t_a c_a + t_a c_b + t_b c_b <=& t_b c_b + t_a c_a + t_b c_a\
t_a c_b <= t_b c_a\
c_b/t_b <= c_a/t_a
$

Now notice that this inequality is transitive, that is $c_x/t_x <= c_y/t_y$ and $c_y/t_y <= c_z/t_z$ implies $c_x/t_x <= c_z/t_z$.

All this combined indicates that we can be greedy by picking the task with maximum $C[i]/T[t]$ and so on. And hence, we can simply sort with respect to the ratio to get our answer.

#idea[
  If the substructure is local and the switching inequality transitive, we can run greedy onto the switching inequality.
]
Another problem we could have is as follows:
#problem[
  - There are $N$ tasks you need to do.
  - Every task takes 1 hour to finish
  - Task $i$ has deadline $d_i$ hours
  - For every hour that passes after the deadline $d_i$, until task $i$ is done, pay $c_i$
]

Can you see the greedy here?

Unfortunately, as we will further see, the greedy guarantee is extremely fragile. Consider the combination of the two problems:
#problem[
  - There are $N$ tasks you need to do.
  - Task $i$ takes $t_i$ hours
  - Task $i$ has deadline $d_i$ hours
  - For every hour that passes after the deadline $d_i$, until task $i$ is done, pay $c_i$

We want to minimize the cost in finishing the tasks.
]

Here it is not even immediately clear what we should be greedy over. 

Furthermore, any greedy strategy you could think of, doesn't really work; unless P = NP as this problem is NP Complete.

Finally, to finish this section of, I'll talk about another shortcoming of greedy.

#problem[
  - There are $n$ bamboos
  - Each bamboo grows everyday a length of $g_i$ meters such that $sum g_i = 1$.
  - You have a robotic panda that can cut one bamboo a day

Over the time horizon, what is the minimum the tallest bamboo could get?
]
This is called the Bamboo Trimming Problem#footnote[Scheduling problems tends to have funny names. There is Polyamorous Scheduling and Pinwheel Scheduling and what not.]

It can be proven (non constructively) that the optimal backlog any Panda could achieve is $2$. But what algorithm achieves this?

Two greedy ideas could be:
- *Reduce-Max*: Cut the tallest bamboo
- *Reduce-Fastest(x)*: Cut the fastest growing bamboo that is currently taller than some $x$

As it turns out, Reduce Max is conjuctured to achieve the optimal backlog of $2$ (although the proof is elusive, we currently have a proof to show it performs strictly better than $4$) and *Reduce-Fastest* doesn't.

The problem with such conjectures is that they are extremely hard to verify experimentally. For example, Reduce Fastest with $x = 1$ was conjectured to achieve the optimal backlog of $2$ but then 18 years later, in 2022, a counter example was found.

#thm[
For any $epsilon > 0$, there exists some  $n in N$ such that
$"Reduce-Fastest"(x)$ allows for backlog at least  $x + 1 - epsilon$.
]
#proof[
  Simply consider $n$ bamboos with growth rates $1/n$.

  Clearly, no bamboo is cutdown till they simultaneously achieve a height greater than $x$.  Then over the next $n$ time steps, all of the bamboos will be cut down, with the last bamboo reaching height atleast $x + (n-1)/n = x + 1 - 1/n$.

  Thus, we can set $n = ceil(1/epsilon)$.
]

#thm[
  For no $x in RR$, the backlog of $"Reduce-Fastest"(x)$ can't be less than 2.
]
#proof[
  This implies we have to have $x < 1 + epsilon$ as otherwise the backlog can exceed 2. 

  Notice, for $0.5 < x < 1$, we can simply fail it with two bamboos, one with growth rate $x$ and other with $1 - x$. The panda will keep cutting the fast bamboo while the slow one keeps growing unboundedly.

  As for $1 < x < 1 + epsilon$? We will just make a single construction that works from $1 < x < 1.01$...

  Suppose we have $900$ bamboo with growth rates $1/1000$ and $140$ bamboo with growth rates $1/1400$. This idea is very similar to the above construction with a fast and slow bamboo.

  The fast bamboo achieve height $x$ somewhere between time $1000$ and time $1010$ depending on $x$. 

  Then each of the $900$ fast bamboo are cut down, and then some proper subset of the slow bamboo are cut down until the first cut of the fast bamboo again achieves height  at some time no later than $2020$.

  Then the fast bamboo are again all cut. By the time that all of the fast bamboo have been cut exactly twice, at least $2900$ time steps have elapsed, and some slow bamboo remains uncut with height at least $2900/1400 > 2.01$.
]

So basically, we want to cut the fastest bamboo but we can't really ignore the slow crawlers. Can we somehow formalize this?

#algo[
*Deadline-Driven-Strategy* is as follows: of all bamboos of height atleast $1$, cut the one that has the lowest $(2 - h_i)/(g_i)$.
]

Basically, we cut the bamboo that is scheduled earliest to reach our backlog of $2$. 

And as it turns out, we can prove that it achives the backlog of 2 and hence is optimal. While the proof is rather tedious so I will not be discussing that, feel free to check it from the paper _Bamboo Trimming Revisited: Simple Algorithms Can Do Well Too_ by _John Kuszmaul_.

= Compression
One of my favorite stories in CS goes as follows.

Robert Fano (yet another legendary Computer Scientist) was taking a class on information theory at MIT. One of the PhD scholars attending the class was David Huffman. 

Fano had offered a choice of taking the finals or submitting a term paper. This was sort of a false choice as the term paper topic was finding the optimal binary code, a famous unsolved problem that Fano and Shanon (another legendary CS person) had worked upon but they were failing to  Huffman wanted to go on a trip with some friends and hence, didn't want to write the exam. So he asked Fano