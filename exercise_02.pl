% Exercise 2 - Prolog

member(X, [X|_]).
member(X, [_|Tail]) :- member(X, Tail).

insert(X, List, Result) :- append(Left, Right, List), append(Left, [X|Right], Result).

% Task 1:

% permutation(List, [X|P]) :- member(X, List), remove(X, List, NewList), permutation(NewList, P). 
% permutation([], []).

permutation1([],[]).
permutation1([Head|Tail], Result) :- permutation1(Tail, NewList), insert(Head, NewList, Result).

% Task 2:
lessOrEqual(X, Y) :- X =< Y.

% isSorted(List) (forall x \in L) (forall y \in L after x) lessOrEqual(x,y)

% isSorted(L) :- not((append(_, [X, Y|_], L), not(lessOrEqual(X, Y)))).
isSorted([]).
isSorted([_]).
isSorted([First, Second|Tail]) :- lessOrEqual(First, Second), isSorted([Second|Tail]).

% Task 3:

/*
Ax -> \forall x
Ex -> \exists x
-F -> \neg F

AxF |*| -Ex-F
|= AxF <-> -Ex-F

X - list of numbers
Y - list of lists of numbers
*/

% p1(X, Y) <-> Ex \in X, Ey \in Y, x \in y
p1(X, Y) :- member(A, X), member(B, Y), member(A, B).

% p2(X, Y) <-> Ex \in X, Ay \in Y, x \in y
p2(X, Y) :- member(A, X), not((member(B, Y), not(member(A, B)))).
% Ea \in x, Eb \in Y: member(a,b) |=| Ea \in X, -Eb \in Y: -member(x, y)

% p3(X, Y) <-> Ax \in X, Ey \in Y, x \in y
p3(X, Y) :- not((member(A, X), not((member(B, Y), member(A, B))))).
% Aa \in x, Eb \in Y: member(a,b) |=| -Ea \in X, -Eb \in Y: member(a,b)

% p4(X, Y) <-> Ax \in X, Ay \in Y, x \in y
p4(X, Y) :- not((member(A, X), member(B, Y), not(member(A, B)))).
% Aa \in x, Ab \in Y: member(a,b) |=| -Ea \in X, --Eb \in Y: -member(a,b) |=| -Ea \in X, Eb \in Y: -member(a, b)

% Task 4:

prefix(List, Prefix) :- append(Prefix, _, List).
suffix(List, Suffix) :- append(_, Suffix, List).

%infix(List, Sublist) :- append(Prefix, _, List), append(_ Sublist, Prefix).
%infix(List, Sublist) :- append(_, Suffix, List), append(Sublist, _, Suffix).
%infix(List, Sublist) :- suffix(List, Suffix), prefix(Suffix, Sublist).
infix(List, Sublist) :- prefix(List, Prefix), suffix(Prefix, Sublist).

% [a, b, c] -> [1, 1, 1]
% [a, c] -> [1, 0, 1]
subsequence([], []).
subsequence([_|Tail], Result) :- subsequence(Tail, Result). 
subsequence([Head|Tail], [Head|Result]) :- subsequence(Tail, Result).

% isSubset(List1, List2) :- not((member(X, List1), not(member(X, List2)))).

isSubset([], _).
isSubset([Head|Tail], List) :- member(Head, List), isSubset(Tail, List).

% Task 5:

% m(L, M)
% Generate all lists in M that are elements of List:
m(_, []).
m(List, [Head|Tail]) :- m(List, Tail), member(Head, List).

% HW:
% reverse(List, Result).