:- consult('utils.pl').
:- consult('display.pl').
:- consult('players.pl').

play :-
	start_game.
	
start_game :-
	initial(Initial),
	get_player(P1, 1),
	display_game(Initial, P1).