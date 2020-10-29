:- consult('utils.pl').
:- consult('display.pl').
:- consult('players.pl').

%play
play :-
	start_game.

%start_game	
start_game :-
	initial(Initial),
	get_current_player(P1, 1),
	display_game(Initial, P1).