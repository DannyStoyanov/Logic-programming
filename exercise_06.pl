% Exercise 6
:- use_module(library(clpfd)).

% #=, #<=, #>=, #>, #<
len([], N) :- N #= 0.
len([_|Tail], N) :- N #> 0, len(Tail, N-1).

% 3 #= X + Y, X #> 0, Y #> 0, label([X,Y]).

evenLen1([]).
evenLen1([_,_|List]) :- evenLen1(List).

evenLen2(L) :- len(L, 2*_).

between1(A, B, A) :- A =< B.
between1(A, B, X) :- A < B, A1 is A+1, between(A1, B, X). 

between2(A, B, A) :- A #=< B.
between2(A, B, X) :- A #< B, A1 #= A+1, between(A1, B, X). 

between3(A, B, C) :- A #=< B, C #= A.
between3(A, B, X) :- A #< B, between3(A+1, B, X).

between4(A, B, C) :- C in A..B.

range1(A, B, []) :- A #> B.
range1(A, B, [A|R]) :- A #< B, A1 #= A+1, range1(A1, B, R).

range2(A, B, L) :- len(L, B-A+1), all_distinct(L), chain(L, #<), L ins A..B, label(L).

nthElement1([Head|_], 0, Head).
nthElement1([_|Tail], N, X) :- nthElement1(Tail, M, X), N is M + 1.

nthElement2([Head|_], N, Head) :- N #= 0.
nthElement2([_|Tail], N, X) :- N #> 0, nthElement2(Tail, N-1, X).

append([], B, B).
append([Head|Tail], B, [Head|Result]) :- append(Tail, B, Result).

remove(X, L, R) :- append(Y, [X|Z], L), append(Y, Z, R).

perm([],[]).
perm(List, [Head|Result]) :- remove(Head, List, Q), perm(Q, Result).

perm(L, P) :- len(L, N), len(I, N), N1 #= N-1, I ins 0..N1, all_distinct(I), maplist(nthElement2(L), I, P).

fact1(0, 1).
fact1(N, F) :- N > 0, N1 is N-1, fact1(N1, F1), F is N*F1.

fact2(N, F) :- N #= 0, F #= 1.
fact2(N, F) :- N #> 0, F #= F1*N, fact2(N-1, F1).

graph([[a, b, c, d], [[a, b], [b, c], [c, d], [c, a]]]).
edge([_, E], X, Y) :- member([X, Y], E), member([X, Y], E).

:- table path(+, +, +, -).
path(_, Y, Y, [Y]).
path(Graph, X, Y, [X|Path]) :- edge(Graph, X, Z), path(Graph, Z, Y, Path).

fib1(0, 1).
fib1(Y, Z) :- fib1(X, Y), Z is X+Y.
fib1(X) :- fib1(X, _).

fib2(N, 0) :- N #= 0.
fib2(N, 1) :- N #= 1.
fib2(N, Z) :- N #> 1, Z #= X+Y, fib2(N-1, X), fib2(N-2, Y).

natural(X) :- between(0, inf, X).
fib3(X) :- natural(N), fib2(N, X).

range3(A, B, R) :- bagof(X, between(A, B, X), R).

% Farey
farey(L):- generateFarey(L, _).

generateFarey([[0, 1], [1, 1]], 1).
generateFarey(FNplus1, Nplus1):- Nplus1 #= N + 1, generateFarey(FN, N), addPairs(FN, Nplus1, FNplus1).

addPairs([X], _, [X]).
addPairs([[A, B], [C, D]|Tail], Nplus1, [[A, B], [AplusC, Nplus1]|R]):- 
        B + D #= Nplus1, AplusC #= A + C, 
        addPairs([[C, D]|Tail], Nplus1, R).
addPairs([[A, B], [C, D]|Tail], Nplus1, [[A, B]|R]):- 
        B + D #\= Nplus1, 
        addPairs([[C, D]|Tail], Nplus1, R).