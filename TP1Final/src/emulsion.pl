:- consult('utils.pl').
:- consult('display.pl').
:- consult('menus.pl').
:- consult('io.pl').
:- consult('game.pl').
:- use_module(library(random)).

%play
play :-
	clearScreen,
	mainMenu.