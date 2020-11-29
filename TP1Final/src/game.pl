%startGame(+Player1, +Player2)
startGame :-
	initial(InitialBoard),
	gameState(1, InitialBoard, GameState),
	doRound(GameState).

next_turn('Player1', 'Player2').
next_turn('Player2', 'Player1').

%changeTurn(+GameState)
changeTurn([H|T]) :-
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
valid_moves([_|Board], Player, ListOfMoves) :-
	positionsList(ListOfPositions),
	getPieceType(Player, PieceType),
	valid_movesAux(Board, 9, ListOfPositions, PieceType, [], ListOfMoves).

valid_movesAux([], _, [], _, PlaceHolderList, ListOfMoves) :-
	ListOfMoves = PlaceHolderList.
valid_movesAux([[CurrentPiece|_]|RestOfRows], 0, [[PositionRow|[PositionColumn|_]]|TailListOfPositions], PieceType, PlaceHolderList, ListOfMoves) :-
	CurrentPiece == PieceType,
	append([[PositionRow, PositionColumn]], PlaceHolderList, Aux),
	valid_movesAux(RestOfRows, 9, TailListOfPositions, PieceType, Aux, ListOfMoves);
	valid_movesAux(RestOfRows, 9, TailListOfPositions, PieceType, PlaceHolderList, ListOfMoves).
valid_movesAux([[CurrentPiece|RestOfColumns]|RestOfRows], BoardCounter, [[PositionRow|[PositionColumn|_]]|TailListOfPositions], PieceType, PlaceHolderList, ListOfMoves) :-
	CurrentPiece == PieceType,
	Counter is BoardCounter - 1,
	append([[PositionRow, PositionColumn]], PlaceHolderList, Aux),
	valid_movesAux([RestOfColumns|RestOfRows], Counter, TailListOfPositions, PieceType, Aux, ListOfMoves);
	Counter is BoardCounter - 1,
	valid_movesAux([RestOfColumns|RestOfRows], Counter, TailListOfPositions, PieceType, PlaceHolderList, ListOfMoves).
	

%move(+GameState, +Move, -NewGameState)​
%move(GameState, Move, NewGameState).

 
%TODO criar caso de desempate
%check for the winner
checkWinner(GameState, Winner):-
	value(GameState, 1, Val1),
	value(GameState, 2, Val2),
	getWinner(Val1, Val2, Winner).
	
getWinner(Val1, Val2, Winner) :-
	Val1 < Val2,
	Winner = 'Player1';
	Val1 > Val2,
	Winner = 'Player2';
	Val2 == Val1,
	Winner = 'Tie'.

%game_over(+GameState, -Winner)
game_over(GameState, Winner):-
	write('Game Over!\n'),
    checkWinner(GameState,Winner),
	format('\n ~w is the winner!', Winner).

%value(+GameState, +Player, -Value)​
value([_|Board], Player, Value) :-
	positionsList(ListOfPositions),
	getPieceType(Player, PieceType),
	getLargestGroup(Board, ListOfPositions, [], PieceType, 0, MaxValue),
	Value = MaxValue.

%pieceValue(+GameState, +PieceRow, +PieceColumn, -Value)
pieceValue([_|Board], PieceRow, PieceColumn, Value) :-
	getPiece(Board, PieceRow, PieceColumn, PieceType),
	getGroup(Board, PieceRow, PieceColumn, PieceType, [], _, Value).

%choose_move(+GameState, +Player, +Level, -Move)
%choose_move(GameState, Player, Level, Move).

%getLargestGroup(+Board, +ListOfPositions, +ListOfCheckedPositions, +PieceType, +ValuePlaceholder, -MaxValue)
getLargestGroup(_, [], _, _, ValuePlaceholder, MaxValue) :-
	MaxValue is ValuePlaceholder.
getLargestGroup(Board, [[PositionRow|[PositionColumn|_]]|TailListOfPositions], ListOfCheckedPositions, PieceType, ValuePlaceholder, MaxValue) :-
	ground(ValuePlaceholder),
	\+ member([PositionRow|PositionColumn], ListOfCheckedPositions),
	getPiece(Board, PositionRow, PositionColumn, Piece),
	Piece == PieceType,
	getGroup(Board, PositionRow, PositionColumn, PieceType, ListOfCheckedPositions, NewListOfCheckedPositions, GroupValue),!,
	GroupValue > ValuePlaceholder ->
	getLargestGroup(Board, TailListOfPositions, NewListOfCheckedPositions, PieceType, GroupValue, MaxValue);
	getLargestGroup(Board, TailListOfPositions, ListOfCheckedPositions, PieceType, ValuePlaceholder, MaxValue).

%getGroup(+Board, +PositionRow, +PositionColumn, +PieceType, +ListOfCheckedPositions, -NewListOfCheckedPositions, -GroupValue)
getGroup(Board,PositionRow, PositionColumn, PieceType, ListOfCheckedPositions, NewListOfCheckedPositions, GroupValue) :-
	PositionRow >= 0,
	PositionRow =< 9,
	PositionColumn >= 0,
	PositionColumn =< 9,
	\+ member([PositionRow|PositionColumn], ListOfCheckedPositions),
	append([[PositionRow|PositionColumn]], ListOfCheckedPositions, AuxList1),
	getPiece(Board, PositionRow, PositionColumn, Piece),!,
	Piece == PieceType ->
	AuxTop is PositionRow-1,
	AuxBottom is PositionRow+1,
	AuxLeft is PositionColumn-1,
	AuxRight is PositionColumn+1,
	getGroup(Board, AuxTop, PositionColumn, PieceType, AuxList1, AuxList2, GroupValueTop),
	getGroup(Board, AuxBottom, PositionColumn, PieceType, AuxList2, AuxList3, GroupValueBottom),
	getGroup(Board, PositionRow, AuxLeft, PieceType, AuxList3, AuxList4, GroupValueLeft),
	getGroup(Board, PositionRow, AuxRight, PieceType, AuxList4, NewListOfCheckedPositions, GroupValueRight),
	GroupValue is 1 + GroupValueTop + GroupValueBottom + GroupValueLeft + GroupValueRight;
	\+ ground(NewListOfCheckedPositions),
	PositionRow >= 0,
	PositionRow =< 9,
	PositionColumn >= 0,
	PositionColumn =< 9,
	\+ member([PositionRow|PositionColumn], ListOfCheckedPositions),
	append([[PositionRow|PositionColumn]], ListOfCheckedPositions, AuxList1),
	NewListOfCheckedPositions = AuxList1,
	GroupValue = 0;
	\+ ground(NewListOfCheckedPositions),
	NewListOfCheckedPositions = ListOfCheckedPositions,
	GroupValue = 0;
	GroupValue = 0.

%gameState(+Player, +Board, -GameState)
gameState(Player, Board, GameState) :-
	append([Player], Board, GameState).

%isHuman(+Player)
isHuman(1).
isHuman(2).

%isBot(+Player)
isBot(-1).
isBot(-2).

%getPieceType(+Player, -PieceType)
getPieceType(Player, PieceType) :-
	Aux is abs(Player),
	Aux == 1,
	PieceType = 'black';
	Aux is abs(Player),
	Aux == 2,
	PieceType = 'white'.