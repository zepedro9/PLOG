:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).

% Tabuleiro 6vs6
% A1, A2, A3, A4, A5, A6
% B1, B2, B3, B4, B5, B6
% C1, C2, C3, C4, C5, C6
% D1, D2, D3, D4, D5, D6
% E1, E2, E3, E4, E5, E6
% F1, F2, F3, F4, F5, F6

% Cell values:
% -2 = No Information
% -1 = Mine
% 0 = 0
% 1 = 1
% 2 = 2
% 3 = 3
% 4 = 4
%
% Obs: With the given restrictions, a higher value than 4 in any cell is impossible.

dominosweeper(N, List) :-
	matrixN(N, List, Rows, Columns),
	domain(List, -1, 4).
	
	
	% Each mine is adjacent to exactly one other mine -v
	
	% Each mine is adjacent to exactly one other mine -^
	
	% Each cell with a number is adjacent to exactly that number of mines among the cells touching it -v
	
	% Each cell with a number is adjacent to exactly that number of mines among the cells touching it -

%matrixN(+N, -List, -Rows, -Columns)
matrixN(N, List, Rows, Columns) :-
	length(Rows, N), 
	maplist(same_length(Rows), Rows),
	append(Rows, List),
	transpose(Rows, Columns).
   
example_problem([
	[2, -2, -2, -2, -2, -2],
	[-2, -2, -2, -2, -2, -2],
	[-2, -2, -2, 3, -2, 3],
	[2, -2, 0, -2, -2, -2],
	[-2, -2, -2, -2, -2, -2],
	[-2, -2, -2, -2, -2, 1]
]).

tester([
	['A1', 'A2', 'A3', 'A4', 'A5', 'A6'],
	['B1', 'B2', 'B3', 'B4', 'B5', 'B6'],
	['C1', 'C2', 'C3', 'C4', 'C5', 'C6'],
	['D1', 'D2', 'D3', 'D4', 'D5', 'D6'],
	['E1', 'E2', 'E3', 'E4', 'E5', 'E6'],
	['F1', 'F2', 'F3', 'F4', 'F5', 'F6']
]).