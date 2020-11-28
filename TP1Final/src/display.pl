%initial(-GameState)
initial([
	[black, white, black, white, black, white, black, white, black, white],
	[white, black, white, black, white, black, white, black, white, black],
	[black, white, black, white, black, white, black, white, black, white],
	[white, black, white, black, white, black, white, black, white, black],
	[black, white, black, white, black, white, black, white, black, white],
	[white, black, white, black, white, black, white, black, white, black],
	[black, white, black, white, black, white, black, white, black, white],
	[white, black, white, black, white, black, white, black, white, black],
	[black, white, black, white, black, white, black, white, black, white],
	[white, black, white, black, white, black, white, black, white, black]
]).

%position(+Piece, -Representation)
position(black, P) :- P='| B '.
position(white, P) :- P='|   '.

%printBoard(+BoardState, +CurrentPlayer)
printBoardState(Initial) :-
	write('-=x=-=x=-=x=-=x=-=x=-=x=-=x=- Emulsion -=x=-=x=-=x=-=x=-=x=-=x=-=x=-'),
	nl,nl,nl,
	write('    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |'),
	nl,
	printBoard(Initial, 0).

%printBoard(+BoardState, +LineNumber)
printBoard([], 10) :-
	write(' ------------------------------------------- ').
printBoard([FirstLine|Rest], N) :-
	write(' ------------------------------------------- '),
	nl,
	write('  '),
	write(N),
	write(' '),
	N1 is N + 1,
	print_line(FirstLine),
	nl,
	printBoard(Rest, N1).

%print_line(+BoardStateLine)	
print_line([]) :-
	write('|').
print_line([FirstSpot|Rest]) :-
	position(FirstSpot, L),
	write(L),
	print_line(Rest).
	