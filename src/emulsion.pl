:- consult('utils.pl').
:- consult('display.pl').
:- consult('players.pl').

play :-
	start_game.
	
start_game :-
	initial(Initial),
	create_player(P1),
	display_game(Initial, P1).