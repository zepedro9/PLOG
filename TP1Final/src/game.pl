%startGame(+Player1, +Player2)
startGame(Player1, Player2) :-
	initial(InitialBoard),
	doRound(InitialBoard, Player1, Player2, Player1).
	
%doRound(+InitialBoard, +Player1, +Player2, +CurrentTurn)
doRound(InitialBoard, Player1, Player2, CurrentTurn).
	
	
%valid_moves(+GameState, +Player, -ListOfMoves)
valid_moves(GameState, Player, ListOfMoves).

%move(+GameState, +Move, -NewGameState)​
move(GameState, Move, NewGameState)​.

%game_over(+GameState, -Winner)
game_over(GameState, Winner).

%value(+GameState, +Player, -Value)​
value(GameState, Player, Value)​.

%choose_move(+GameState, +Player, +Level, -Move)
choose_move(GameState, Player, Level, Move)​.

%isHuman(+Player)
isHuman(Player) :-
	Player == 1.