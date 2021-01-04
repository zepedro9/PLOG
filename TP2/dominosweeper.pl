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
	





getNeighbours(BoardList, Indice, NumRows, NumCols, Neighbours) :-
	TopLeftI is Indice - NumCols - 1,
	TopMidI is Indice - NumCols,
	TopRightI is Indice - NumCols + 1,
	MidLeftI is Indice - 1,
	MidRightI is Indice + 1,
	BottomLeftI is Indice + NumCols - 1,
	BottomMidI is Indice + NumCols,
	BottomRightI is Indice + NumCols + 1,
	Max is NumCols * NumRows - 1,
	getNeighbour(BoardList, TopLeftI, Max, [], Neighbours1),
	getNeighbour(BoardList, TopMidI, Max, Neighbours1, Neighbours2),
	getNeighbour(BoardList, TopRightI, Max, Neighbours2, Neighbours3),
	getNeighbour(BoardList, MidLeftI, Max, Neighbours3, Neighbours4),
	getNeighbour(BoardList, MidRightI, Max, Neighbours4, Neighbours5),
	getNeighbour(BoardList, BottomLeftI, Max, Neighbours5, Neighbours6),
	getNeighbour(BoardList, BottomMidI, Max, Neighbours6, Neighbours7),
	getNeighbour(BoardList, BottomRightI, Max, Neighbours7, Neighbours).

getNeighbour(BoardList, Indice, Max, OldList, NewList) :-
	Indice < 0,
	NewList = OldList;
	Indice > Max,
	NewList = OldList;
	getElement(BoardList, Indice, Value),
	append(OldList, [Value], NewList).

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

exampleProblem([
	[2, _, _, _, _, _],
	[_, _, _, _, _, _],
	[_, _, _, 3, _, 3],
	[2, _, 0, _, _, _],
	[_, _, _, _, _, _],
	[_, _, _, _, _, 1]
]).