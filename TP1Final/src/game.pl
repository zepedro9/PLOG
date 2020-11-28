%startGame(+Player1, +Player2)
startGame(Player1, Player2) :-
	initial(InitialBoard),
	gameState(Player1, InitialBoard, GameState),
	doRound(GameState).
	


next_turn('Player1', 'Player2').
next_turn('Player2', 'Player1').

changeTurn([H|T]):-
	next_turn(H, NewPlayer),
	GameState = [NewPlayer|T],
	gameState(NewPlayer, T, GameState).


%doRound(+GameState)
doRound(GameState):-
	%condição de paragem
	game_over(GameState, Winner).

%doRound(+GameState)
doRound(GameState):-
	% \+condição de paragem 
	format('Player ~w turn', [H|_]),
	move(GameState, Move, NewGameState),
	changeTurn(GameState),
	doRound(GameState).

	
%valid_moves(+GameState, +Player, -ListOfMoves)
valid_moves(GameState, Player, ListOfMoves).

%move(+GameState, +Move, -NewGameState)​
move(GameState, Move, NewGameState).

 
%TODO criar caso de desempate
%check for the winner
checkWinner(GameState, Winner):-
	value(GameState, Player1, Val1),
	value(GameState, Player2, Val2),
		Val1 @< Val2,
		Winner = 'Player1';
        Val2 @< Val1,
		Winner = 'Player2'.

%game_over(+GameState, -Winner)
game_over(GameState, Winner):-
	write('Game Over!\n'),
    checkWinner(GameState,Winner),
	format('\n ~w is the winner!', Winner).

%value(+GameState, +Player, -Value)​
value(GameState, Player, Value).

%choose_move(+GameState, +Player, +Level, -Move)
choose_move(GameState, Player, Level, Move).

%gameState(+Player, +Board, -GameState)
gameState(Player, Board, GameState) :-
	append([Player], Board, GameState).

%isHuman(+Player)
isHuman(1).
isHuman(2).

%isBot(+Player)
isBot(-1).
isBot(-2).