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
	Indice =:= 0,
	MidRightI is Indice + 1,
	BottomMidI is Indice + NumCols,
	BottomRightI is Indice + NumCols + 1,
	Max is NumCols * NumRows - 1,
	getNeighbour(BoardList, MidRightI, Max, [], Neighbours1),
	getNeighbour(BoardList, BottomMidI, Max, Neighbours1, Neighbours2),
	getNeighbour(BoardList, BottomRightI, Max, Neighbours2, Neighbours);
	
	Indice =:= NumCols - 1,
	MidLeftI is Indice - 1,
	BottomLeftI is Indice + NumCols - 1,
	BottomMidI is Indice + NumCols,
	Max is NumCols * NumRows - 1,
	getNeighbour(BoardList, MidLeftI, Max, [], Neighbours1),
	getNeighbour(BoardList, BottomLeftI, Max, Neighbours1, Neighbours2),
	getNeighbour(BoardList, BottomMidI, Max, Neighbours2, Neighbours);
	
	Indice =:= NumCols * (NumRows - 1),
	TopMidI is Indice - NumCols,
	TopRightI is Indice - NumCols + 1,
	MidRightI is Indice + 1,
	Max is NumCols * NumRows - 1,
	getNeighbour(BoardList, TopMidI, Max, [], Neighbours1),
	getNeighbour(BoardList, TopRightI, Max, Neighbours1, Neighbours2),
	getNeighbour(BoardList, MidRightI, Max, Neighbours2, Neighbours);
	
	Indice =:= NumCols * NumRows - 1,
	TopLeftI is Indice - NumCols - 1,
	TopMidI is Indice - NumCols,
	MidLeftI is Indice - 1,
	Max is NumCols * NumRows - 1,
	getNeighbour(BoardList, TopLeftI, Max, [], Neighbours1),
	getNeighbour(BoardList, TopMidI, Max, Neighbours1, Neighbours2),
	getNeighbour(BoardList, MidLeftI, Max, Neighbours2, Neighbours);
	
	isBetween(0, NumCols, Indice),
	MidLeftI is Indice - 1,
	MidRightI is Indice + 1,
	BottomLeftI is Indice + NumCols - 1,
	BottomMidI is Indice + NumCols,
	BottomRightI is Indice + NumCols + 1,
	Max is NumCols * NumRows - 1,
	getNeighbour(BoardList, MidLeftI, Max, [], Neighbours1),
	getNeighbour(BoardList, MidRightI, Max, Neighbours1, Neighbours2),
	getNeighbour(BoardList, BottomLeftI, Max, Neighbours2, Neighbours3),
	getNeighbour(BoardList, BottomMidI, Max, Neighbours3, Neighbours4),
	getNeighbour(BoardList, BottomRightI, Max, Neighbours4, Neighbours);
	
	Indice mod NumRows =:= 0,
	TopMidI is Indice - NumCols,
	TopRightI is Indice - NumCols + 1,
	MidRightI is Indice + 1,
	BottomMidI is Indice + NumCols,
	BottomRightI is Indice + NumCols + 1,
	Max is NumCols * NumRows - 1,
	getNeighbour(BoardList, TopMidI, Max, [], Neighbours1),
	getNeighbour(BoardList, TopRightI, Max, Neighbours1, Neighbours2),
	getNeighbour(BoardList, MidRightI, Max, Neighbours2, Neighbours3),
	getNeighbour(BoardList, BottomMidI, Max, Neighbours3, Neighbours4),
	getNeighbour(BoardList, BottomRightI, Max, Neighbours4, Neighbours);
	
	Aux2 is NumCols * (NumRows - 1) ,
	Aux3 is NumCols * NumRows - 1,
	isBetween(Aux2, Aux3, Indice),
	TopLeftI is Indice - NumCols - 1,
	TopMidI is Indice - NumCols,
	TopRightI is Indice - NumCols + 1,
	MidLeftI is Indice - 1,
	MidRightI is Indice + 1,
	Max is NumCols * NumRows - 1,
	getNeighbour(BoardList, TopLeftI, Max, [], Neighbours1),
	getNeighbour(BoardList, TopMidI, Max, Neighbours1, Neighbours2),
	getNeighbour(BoardList, TopRightI, Max, Neighbours2, Neighbours3),
	getNeighbour(BoardList, MidLeftI, Max, Neighbours3, Neighbours4),
	getNeighbour(BoardList, MidRightI, Max, Neighbours4, Neighbours);
	
	Aux4 is Indice + 1,
	Aux4 mod NumRows =:= 0,
	TopLeftI is Indice - NumCols - 1,
	TopMidI is Indice - NumCols,
	MidLeftI is Indice - 1,
	BottomLeftI is Indice + NumCols - 1,
	BottomMidI is Indice + NumCols,
	Max is NumCols * NumRows - 1,
	getNeighbour(BoardList, TopLeftI, Max, [], Neighbours1),
	getNeighbour(BoardList, TopMidI, Max, Neighbours1, Neighbours2),
	getNeighbour(BoardList, MidLeftI, Max, Neighbours2, Neighbours3),
	getNeighbour(BoardList, BottomLeftI, Max, Neighbours3, Neighbours4),
	getNeighbour(BoardList, BottomMidI, Max, Neighbours4, Neighbours);
	
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

isBetween(Min, Max, Value) :-
	(Value #>= Min) #/\ (Value #=< Max).

exampleProblem([
	[2, _, _, _, _, _],
	[_, _, _, _, _, _],
	[_, _, _, 3, _, 3],
	[2, _, 0, _, _, _],
	[_, _, _, _, _, _],
	[_, _, _, _, _, 1]
]).