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

%intermediate(-GameState)
intermediate([
	[black, white, black, white, black, white, black, white, black, white],
	[white, black, white, white, white, black, black, black, black, black],
	[black, black, black, black, white, white, white, black, black, white],
	[white, black, black, white, white, black, white, white, black, white],
	[black, black, white, black, white, black, white, white, white, white],
	[white, black, white, black, white, white, white, black, white, white],
	[black, white, white, black, black, black, black, black, black, white],
	[white, white, black, black, black, black, black, black, black, black],
	[white, black, white, white, white, white, black, black, black, black],
	[black, black, white, white, black, white, black, white, black, black]
]).

%final(-GameState)
final([
	[black, black, white, white, white, black, black, white, white, black],
	[black, black, white, white, white, black, black, black, black, black],
	[white, black, black, black, white, white, white, black, black, black],
	[white, black, black, black, white, white, white, white, white, white],
	[white, black, white, white, white, white, white, white, white, white],
	[black, black, white, white, white, white, black, black, white, white],
	[black, black, black, black, black, black, black, black, black, white],
	[white, black, black, black, black, black, black, black, black, black],
	[white, white, white, black, black, black, black, black, black, black],
	[black, black, white, white, white, white, white, white, black, black]
]).

%position(+Piece, -Representation)
position(black, P) :- P='| B '.
position(white, P) :- P='|   '.

%display_game(+GameState, +CurrentPlayer)
display_game(Initial, P) :-
	clear_screen,
	write('-=x=-=x=-=x=-=x=-=x=-=x=-=x=- Emulsion -=x=-=x=-=x=-=x=-=x=-=x=-=x=-'),
	nl,nl,nl,
	write('    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |'),
	nl,
	print_board(Initial, 0),
	print_next_move_request(P).
	%print_win_message(P, '55 to 45').

%print_next_move_request(+CurrentPlayer)
print_next_move_request(P) :-
	nl,nl,
	write('E a vez do '),
	write(P),
	write('!'),
	nl,
	write('Choose your next move: ').

%print_win_message(+CurrentPlayer, +Result)
print_win_message(P, Res) :-
	nl,nl,
	write('O '),
	write(P),
	write(' ganhou!'),
	nl,
	write('Resultado final: '),
	write(Res),
	write('.').

%print_board(+GameState, +LineNumber)
print_board([], 10) :-
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

%print_line(+GameStateLine)	
print_line([]) :-
	write('|').
print_line([FirstSpot|Rest]) :-
	position(FirstSpot, L),
	write(L),
	print_line(Rest).
	