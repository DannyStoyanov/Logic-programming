% Exercise 3

append([], List, List).
append([Head|Tail], List, [Head|Result]) :- append(Tail, List, Result).

reverse([], []).
reverse([Head|Tail], Result) :- reverse(Tail, Reversed), append(Reversed, [Head], Result).

% reverse with data structure stack
% reverse(List, Stack, Result)
reverse1(List, Result) :- reverseHelper(List, [], Result).
reverseHelper([], Stack, Stack).
reverseHelper([Head|Tail], Stack, Result) :- reverseHelper(Tail, [Head|Stack], Result).

% Task 1:
palindrome(List) :- reverse(List, Reversed), List = Reversed.

palindrome1([]).
palindrome1([_]).
palindrome1(List) :- append([Head|Tail], [Head], List), palindrome1(Tail).

% Task 2 - Sorting algorithms:
insert(X, List, Result) :- append(Left, Right, List), append(Left, [X|Right], Result).

permutation1([], []).
permutation1([Head|Tail], Result) :- permutation1(Tail, NewList), insert(Head, NewList, Result).

pSort(List, Result) :- permutation(List, Result), isSorted(Result).
isSorted(List) :- not(( append(_, [X,Y|_], List), not(X =< Y))).

% min Ax(x<=m -> m=x)
% least Ax(m =< x)
lessOrEqual(X, Y) :- X =< Y.
min2(X, Y, X) :- lessOrEqual(X, Y).
min2(X, Y, Y) :- not(lessOrEqual(X, Y)).

% Not very effective - double calculation of minElementIntList(Tail, Min2) -> quadratic time complexity
/*
minElementIntList([X], X).
minElementIntList([Head|Tail], Min) :- minElementIntList(Tail, Min2), min2(Head, Min2, Min). 
*/

minElementIntList(List, Min) :- member(Min, List), not(( member(X, List), not(lessOrEqual(Min, X)))).

% Selection sort:
remove(X, [X|Tail], Tail).
remove(X, [Head|Tail], [Head|NewTail]) :- remove(X, Tail, NewTail). 

selectionSort([], []).
selectionSort(List, [Min|Sorted]) :- minElementIntList(List, Min), remove(Min, List, Rest), selectionSort(Rest, Sorted).

% Quicksort:

% split(): A <= X < B
split(_, [], [], []).
split(X, [Head|Tail], [Head|A], B) :- lessOrEqual(Head, X), split(X, Tail, A, B).
split(X, [Head|Tail], A, [Head|B]) :- not(lessOrEqual(Head, X)), split(X, Tail, A, B).

quickSort([], []).
quickSort([Pivot|Tail], Result) :- split(Pivot, Tail, Left, Right), quickSort(Left, SortedLeft), quickSort(Right, SortedRight), append(SortedLeft, [Pivot|SortedRight], Result).

% Mergesort
split([], [], []).
split([X], [X], []).
split([X, Y|Tail], [X|A], [Y|B]) :- split(Tail, A, B).

%merge([], [], []).
merge([], List, List).
merge(List, [], List).
merge([X|A], [Y|B], [X|Tail]) :- lessOrEqual(X, Y), merge(A, [Y|B], Tail).
merge([X|A], [Y|B], [Y|Tail]) :- not(lessOrEqual(X, Y)), merge([X|A], B, Tail).

mergeSort([], []).
mergeSort([X], [X]).
mergeSort(List, Result) :- split(List, Left, Right), mergeSort(Left, SortedLeft), mergeSort(Right, SortedRight), merge(SortedLeft, SortedRight, Result).

% Task 3 - Binary tree Sort:

% tree(Left, Root, Right).
% empty.

%add(X, Tree, NewTree).
%makeTree(List, Tree).
%leftRootRight(Tree, SortedList).
%treeSort(List, SorteList).

add(X, empty, tree(empty, X, empty)).
add(X, tree(LT, R, RT), tree(LT1, R, RT)) :- lessOrEqual(X, R), add(X, LT, LT1).
add(X, tree(LT, R, RT), tree(LT, R, RT1)) :- not(lessOrEqual(X, R)), add(X, RT, RT1).

makeTree([], empty).
makeTree([Head|Tail], Tree) :- makeTree(Tail, RestTree), add(Head, RestTree, Tree).

leftRootRight(empty, []).
leftRootRight(tree(LT, R, RT), List) :- leftRootRight(LT, LeftList), leftRootRight(RT, RightList), append(LeftList, [R|RightList], List).

treeSort(List, Result) :- makeTree(List, Tree), leftRootRight(Tree, Result).
 
 % Task 4 - Cartesian product
d([], []).
d([Head|Tail], [Element|Rest]) :- member(Element, Head), d(Tail, Rest).
