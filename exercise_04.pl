% Exercise 4 - Arithmetic in Prolog

/*
is, =:=, =!=
<, >, =<, >=
+, /, -, *, ^, div, mod
**
*/

% Task 1
% length(List, N)
len([], 0).
len([_|Tail], X) :- len(Tail, Y), X is Y+1.

% Task 2
% sum(List, SumList)
sumList([], 0).
sumList([Head|Tail], Sum) :- sumList(Tail, NextSum), Sum is NextSum + Head. 

% Task 3
%nthElement(X, IndX, List)
nthElement(X, 0, [X|_]).
nthElement(X, N, [_|Tail]) :- nthElement(X, M, Tail), N is M+1.

% Task 4 - Natural numbers N
natural(0).
natural(X) :- natural(Y), X is Y+1.

% Task 5
even1(0).
even1(X) :- natural(Y), X is 2*Y.

even2(X) :- natural(X), X mod 2 =:= 0.

even3(0).
even3(X) :- even3(Y), X is Y+2.
even3(X) :- even3(Y), X is Y-2.

% Task 6 - Whole numbers Z
int1(X) :- natural(Y), decodeInt(Y, X).
decodeInt(Y, X) :- Y mod 2 =:= 0, X is -Y // 2.
decodeInt(Y, X) :- Y mod 2 =:= 1, X is (Y+1) // 2. % Y+1 to avoid two "X = 0" results

int2(X) :- natural(Y), sign(Y, X).
sign(X, X).
sign(X, Y) :- X > 0, Y is -X.

int3(0).
int3(X) :- natural(Y), Y > 0, member(Z, [1, -1]), X is Y*Z.

% Task 7
% between(A, B, X) :- X in [A, B]
between(A, B, A) :- A =< B.
between(A, B, X) :- A < B, A1 is A + 1, between(A1, B, X). 

% finite generator -> between(...)
% infinite generator -> natural(...)
natural20(X) :- between(0, 20, X).

% Task 8
range(A, B, []) :- A > B.
range(A, B, [A|Tail]) :- A1 is A+1, range(A1, B, Tail).

% Task 9 - NxN
%pairNatural(X, Y).
pairNatural(0,0).
pairNatural(X, Y) :- natural(K), between(0, K, X), Y is K-X.

%genNS(N, Sum, List).
genNS(0, 0, []).
genNS(N, Sum, [Head|Tail]) :- N > 0, between(0, Sum, Head), S1 is Sum-Head, N1 is N-1, genNS(N1, S1, Tail).

allNTuples(N, List) :- natural(S), genNS(N, S, List).
allFiniteNatNumberSequences(List) :- pairNatural(N, S), genNS(N, S, List).

% Task 10 - Fibonacci
fib(X) :- fib(X, _).
fib(0, 1).
fib(Y, Z) :- fib(X, Y), Z is X+Y. 

% for cycle
fibCheck(X) :- fib2(0, 1, X).
fib2(X, _, X).
fib2(X, Y, L) :- X < L, Z is X+Y, fib2(Y, Z, L).


% a_0 a_1 = a_2 = 1
% a_(n+3) = a_(n) + a_(n+1) (+ 0*a_(n+2))
a(1, 1, 1).
a(Y, Z, T) :- a(X, Y, Z), Y is X+Y.
a(X) :- a(X, _, _).