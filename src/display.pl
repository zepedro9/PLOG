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

position(black, P) :- P='| B '.
position(white, P) :- P='| W '.

display_game(Initial, P1) :-
	clear_screen,
	write('-=x=-=x=-=x=-=x=-=x=-=x=-=x=- Emulsion -=x=-=x=-=x=-=x=-=x=-=x=-=x=-\n'),
	nl,
	write('    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |'),
	nl,
	print_board(Initial, 0).

print_board([], 9) :-
	write('     _______________________________________ ').
print_board([FirstLine|Rest], N) :-
	write('     _______________________________________ '),
	nl,
	write('| '),
	write(N),
	write(' '),
	N1 is N + 1,
	print_line(FirstLine),
	nl,
	print_board(Rest, N1).
	
print_line([]) :-
	write('|').
print_line([FirstSpot|Rest]) :-
	position(FirstSpot, L),
	write(L),
	print_line(Rest).
	