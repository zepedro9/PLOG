%startGame(+Player1, +Player2)
startGame(Player1, Player2) :-
	initial(InitialBoard),
	gameState(Player1, InitialBoard, GameState),
	doRound(GameState, Player1, Player2, Player1).
	
%doRound(+GameState, +Player1, +Player2, +CurrentTurn)
doRound(GameState, Player1, Player2, CurrentTurn).
	
	
%valid_moves(+GameState, +Player, -ListOfMoves)
valid_moves(GameState, Player, ListOfMoves).

%move(+GameState, +Move, -NewGameState)​
move(GameState, Move, NewGameState).

%game_over(+GameState, -Winner)
game_over(GameState, Winner).

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