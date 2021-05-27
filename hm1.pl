:- use_module(library(clpfd)).
/*
HW:
1. Напишете предикат пресмятащ сумата от елементите на списъка. прим [1,2,3,4] -> сумата е 10
2. Напишете предикат намиращ най-големия/ най-малкия елемент в списък. - има поне два начина да се каже. Единият е с рекурсия и помощна ф-я, 
   а другия игра с квантори.
3. Напишете предикат, който е истина т.с.т.к. X дели Y. прим 5 дели 10, но 5 не дели 27.
*/

% Task 1:
sum1([], 0).
sum1([Head|Tail], N) :- sum1(Tail, M), N is M+Head.

sum2([], N) :- N #= 0.
sum2([Head|Tail], N) :- N #= M+Head, sum2(Tail, M).

sum3([], N) :- N #= 0.
sum3([Head|Tail], N) :- sum3(Tail, N+Head).

% Task 2:
less(X, Y, X) :- X =< Y.
less(X, Y, Y) :- X > Y.
minElement1([X], X).
minElement1([Head|Tail], Min) :- minElement1(Tail, TempMin), less(Head, TempMin, Min).

member(X, [X|_]).
member(X, [_|Tail]) :- member(X, Tail).
minElement2(List, X) :- member(X, List), not(( member(Y, List), X\=Y, Y < X )).

bigger(X, Y, X) :- X >= Y.
bigger(X, Y, Y) :- X < Y.
maxElement1([X], X).
maxElement1([Head|Tail], Max) :- maxElement1(Tail, TempMax),  bigger(Head, TempMax, Max).

maxElement2(List, X) :- member(X, List), not(( member(Y, List), X\=Y, Y > X )).

% Task 3:
div1(_, Y) :- Y =:= 0.
div1(X, Y) :- Y >= X, div1(X, Y-X).

div2(_, 0).
div2(X, Y):- Y >= X, Y1 is Y - X, div2(X, Y1).