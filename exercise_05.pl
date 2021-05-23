% Exercise 5

% Task 1
append([], B, B).
append([Head|Tail], B, [Head|Result]) :- append(Tail, B, Result).

isList([]).
isList([_|_]).

flattenHelper([], []).
flattenHelper(X, [X]) :- not(isList(X)).
flattenHelper([Head|Tail], Result) :- flattenHelper(Head, Res1), flattenHelper(Tail, Res2), append(Res1, Res2, Result). 

flatten(List, Result) :- isList(List), flattenHelper(List, Result).

% Second version
flatten2([], []).
flatten2([Head|Tail], [Head|Result]) :- not(isList(Head)), flatten2(Tail, Result).
flatten2([Head|Tail], Result) :- isList(Head), flatten2(Head, Res1), flatten2(Tail, Res2), append(Res1, Res2, Result). 

% Task 2
split([], []).
split(X, [X]).
split(List, [X|Result]) :- append(X, Y, List), X\=[], split(Y, Result).

% Task 3
between(A, B, A) :- A =< B.
between(A, B, X) :- A < B, A1 is A + 1, between(A1, B, X). 

sums(0, []).
sums(N, [Head|Tail]) :- between(1, N, Head),  N1 is N-Head, sums(N1, Tail).

% Task 4
natural(0).
natural(N) :- natural(M), N is M+1.

tree(T) :- natural(N), tree([N, T]).

tree(0, []).
tree(N, [A, B]) :- N > 0, N1 is N-1, between(0, N1, M), K is N1-M, tree(M, A), tree(K, B).

% Task 5 - Graph = (V, E), V = {a, b, c, ...}, E < {X < V | |X| = 2}
edge([_, E], X, Y) :- member([X, Y], E); member([Y, X], E).

path(Graph, Start, Finish, Path):-pathHelper(Graph, Start, Finish, [], Path).
pathHelper(_, Finish, Finish, Visited, Result):- reverse([Finish|Visited], Result).
pathHelper(Graph, Start, Finish, Visited, Path) :- Start\=Finish, edge(Graph, Start, Frontier), not(member(Frontier, Visited)), pathHelper(Graph, Frontier, Finish, [Start|Visited], Path).

graph([[a, b, c, d], [[a, b], [b, c], [c, d], [c, a]]]).
%graph(G), path(G, a, b, Path).

% Task 6
len([], 0).
len([_|Tail], N) :- len(Tail, N1), N is N1+1.

hasCycle([V, E]) :- edge([V, E], Start, Finish), path([V, E], Start, Finish, Path), len(Path, N), N>2.

% Task 7 - Is graph connected?
%sConnected([V, E]) :- not(( member(X, V), member(Y, V), X\=Y, not(path([V, E], X, Y, _)) )).
isConnected([[X|V], E]) :- not(( member(Y, V), X\=Y, not(path([[X|V],E], X, Y, _)) )).

% Task 8 - Spanning Tree
remove(X, List, Result) :- append(A, [X|B], List), append(A, B, Result).

spanningTree([V, E], ST):- V=[Head|Tail], spanningTree([V, E], [Head], Tail, ST).
spanningTree(_, _, [], []).
spanningTree([V, E], Visited, NotVisited, [[U, W]|ST]):- member(U, Visited), edge([V, E], U, W), 
    member(W, NotVisited), remove(W, NotVisited, NewNotVisited), spanningTree([V, E], [W|Visited], NewNotVisited, ST).

isConnected2(Graph) :- spanningTree(Graph, _).

% Task 9
hasCycle1([V, E]) :- spanningTree([V, E], ST), len(E, N), len(ST, M), N > M.

% Task 10
criticalVertex([V, E], X):- member(X, V), member(A, V), member(B, V), not(member(X, [A, B])), path([V, E], A, B, P), member(X, P), 
    not((path([V, E], A, B, P1), not(member(X, P1)))).
    