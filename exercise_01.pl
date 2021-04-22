% Exercise 1 - Prolog

% Task 1:
parent(maria, ivan).
parent(ivan, peter).
parent(ivan, stoyan).

grandparent(X, Y) :- parent(X ,Z), parent(Z, Y). 

sibling(X, Y) :- parent(Z, X), parent(Z, Y), X\=Y.

ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y). 
% ancestor(X, X).
% ancestor(X, X) :- parent(X, _).
% ancestor(X, X) :- parent(_, X).

% Task 2 - Derivative:
d(x, 1).
d(X, 0) :- number(X).
d(X+Y, DX+DY) :- d(X, DX), d(Y, DY).
d(X*Y, DX*Y + X*DY) :- d(X, DX), d(Y, DY).
d(sin(X), cos(X)*DX) :- d(X, DX).
d(cos(X), -sin(X)*DX) :- d(X, DX).
d(ln(X), 1/X).

% List operations:
isList([]).
isList([_|_]).

first(X, [X|_]).

%second(Y, [_,Y|_]).
second(X, [_|Tail]) :- first(X, Tail).

last(X, [X]).
last(X, [_|Tail]) :- last(X, Tail). 

member(X, [X|_]).
member(X, [_|Tail]) :- member(X, Tail).

append([], List, List).
append([X|Tail], List2, [X|Result]) :- append(Tail, List2, Result).

firstAppendVersion(X, List) :- append([X], _, List).
lastAppendVersion(X, List) :- append(_, [X], List).

memberAppend(X, List) :- append(_, [X|_], List).

% HW:
%insert(X, L, R) :- append(A, B, L), append(A, [X], C), append(C, B, R). 
insert(X, List, Result) :- append(Left, Right, List), append(Left, [X|Right], Result).

%remove(X, List, Result) :- append(Left, [X|Right], List), append(Left, Right, Result).
remove(X, [X|Tail], Tail).
remove(X, [Head|Tail], [Head|NewTail]) :- remove(X, Tail, NewTail). 