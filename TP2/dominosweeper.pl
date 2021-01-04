:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).

% Cell values:
% -1 = Mine
% 0 = 0
% 1 = 1
% 2 = 2
% 3 = 3
% 4 = 4
%
% Obs: With the given restrictions, a higher value than 4 in any cell is impossible.

dominosweeper(Board) :-
   
	% dimensions of the board
	length(Board, NumRows),
	transpose(Board, BoardT),
	length(BoardT, NumCols),
	flattenMatrix(Board, BoardList).

flattenMatrix(List, ElementsList) :- 
	reverse(List, [H|T]),
	flattenMatrixAux(T, NewElementsList),
	append(NewElementsList, H, ElementsList).
	
flattenMatrixAux([],[]).
flattenMatrixAux([H|T], ElementsList) :- flattenMatrixAux(T, NewElementsList),
	append(NewElementsList, H, ElementsList).

getElement([H|_], 0, H).
getElement([_|T], Indice, Value) :-
	Aux is Indice - 1,
	getElement(T, Aux, Value).

isBetween(Min, Max, Value) :-
	(Value #>= Min) #/\ (Value #=< Max).

in_bounds(I,J,Size):-
    I #>= 0,
    I #< Size,
    J #>= 0,
    J #< Size.

decompose(Size,Pos,Res):-
    Y is Size-1,
    domain([I,J],0,Y),
    Term #= I * Size + J,
    Term #= Pos,
    Res = I-J.

adjacent(I1,J,I2,J) :-
    1 #= abs(I1 - I2).

adjacent(I,J1,I,J2) :-
    1 #= abs(J1 - J2).

adjacent(I,J,I1,J1):-
    1 #= abs(I-I1),
    1 #= abs(J-J1).


find_adjacent(Indice, L1, Size, L2, Result) :-
	decompose(Size,Indice,Res),
    Res=W-Z,
    findall(Pos,(adjacent(W,Z,I,J),in_bounds(I,J,Size), Pos #= I*Size+J, nth0(Pos, L1, H), \+member(Pos, getNumbers(L1, L1, 0, [], Numbers))),Result).

getMine(Indice, List, List2, Size) :-
	find_adjacent(Indice, List, Size, List2, Result),
	findall(A, (member(H, Result), getElement(List, H, A)), Elements).

applying_elements(Elements, List, Indice) :-
	nth0(Indice, List, Val),
	count(Mine, Elements, #=, Val).

getNumbers([], _, _, List, FinalList) :- reverse(List, FinalList).
getNumbers([_|T], BoardList, N, List, FinalList) :-
	getElement(BoardList, N, Value),!,
	number(Value) ->
	append([N], List, NewList),
	NewN is N + 1,
	getNumbers(T, BoardList, NewN, NewList, FinalList);
	NewN is N + 1,
	getNumbers(T, BoardList, NewN, List, FinalList).
	
exampleProblem([
	[2, _, _, _, _, _],
	[_, _, _, _, _, _],
	[_, _, _, 3, _, 3],
	[2, _, 0, _, _, _],
	[_, _, _, _, _, _],
	[_, _, _, _, _, 1]
]).
