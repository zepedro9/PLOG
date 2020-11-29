%getHumanPieceSelect(+GameState, -PieceRow, -PieceColumn)
getHumanPieceSelect([Player|Board], PieceRow, PieceColumn) :-
	format('Player ~w, choose a piece you want to move:~n', [Player]),
	readRow(Row),
	validateRow(Row, ValidatedRow),
	readColumn(Column),
	validateColumn(Column, ValidatedColumn),
	validatePieceSelect([Player|Board], ValidatedRow, ValidatedColumn, PieceRow, PieceColumn).
	
readRow(Row) :-
    write('    Row: '),
    read(Row), nl.

readColumn(Column) :-
    write('    Column: '),
    read(Column), nl.

validateRow(Input, ConfirmInput) :-
	number(Input),
    Input >= 0,
	Input =< 9,
	ConfirmInput is Input;
    write('    [ERROR]: The given row is invalid! Has to be between 0 and 9.\n\n'),
    readRow(NewInput),
    validateRow(NewInput, ConfirmInput).

validateColumn(Input, ConfirmInput) :-
	number(Input),
    Input >= 0,
	Input =< 9,
	ConfirmInput is Input;
    write('    [ERROR]: The given column is invalid! Has to be between 0 and 9.\n\n'),
    readColumn(NewInput),
    validateColumn(NewInput, ConfirmInput).

%validatePieceSelect(+GameState, +ValidatedRow, +ValidatedColumn, -PieceRow, -PieceColumn).
validatePieceSelect([1|Board], ValidatedRow, ValidatedColumn, PieceRow, PieceColumn) :-
	getPiece(Board, ValidatedRow, ValidatedColumn, 'black'),
	PieceRow is ValidatedRow,
	PieceColumn is ValidatedColumn;
	write('    [ERROR]: The selected piece choice is invalid! Your selected piece has to be a black piece.\n\n'),
	getHumanPieceSelect([1|Board], PieceRow, PieceColumn).
validatePieceSelect([2|Board], ValidatedRow, ValidatedColumn, PieceRow, PieceColumn) :-
	getPiece(Board, ValidatedRow, ValidatedColumn, 'white'),
	PieceRow is ValidatedRow,
	PieceColumn is ValidatedColumn;
	write('    [ERROR]: The selected piece choice is invalid! Your selected piece has to be a white piece.\n\n'),
	getHumanPieceSelect([2|Board], PieceRow, PieceColumn).

%getHumanPieceMove(+Player, +PieceRow, +PieceColumn, +ListOfMoves, -NewPieceRow, -NewPieceColumn)
getHumanPieceMove(Player, PieceRow, PieceColumn, [Move|Moves], NewPieceRow, NewPieceColumn).
	