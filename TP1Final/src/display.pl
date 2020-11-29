%initial(-Board)
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

%intermediate(-Board)
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

%final(-Board)
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

%pieceRep(+Piece, -Representation)
pieceRep(black, P) :- P='| B '.
pieceRep(white, P) :- P='|   '.

%printPreBoard(+Board, +CurrentPlayer)
printPreBoard(Initial) :-
	write('-=x=-=x=-=x=-=x=-=x=-=x=-=x=- Emulsion -=x=-=x=-=x=-=x=-=x=-=x=-=x=-'),
	nl,nl,nl,
	write('    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |'),
	nl,
	printBoard(Initial, 0).

%printBoard(+Board, +LineNumber)
printBoard([], 10) :-
	write(' ------------------------------------------- ').
printBoard([FirstLine|Rest], N) :-
	write(' ------------------------------------------- '),
	nl,
	write('  '),
	write(N),
	write(' '),
	N1 is N + 1,
	print_line(FirstLine),
	nl,
	printBoard(Rest, N1).

%print_line(+BoardLine)	
print_line([]) :-
	write('|').
print_line([FirstSpot|Rest]) :-
	pieceRep(FirstSpot, L),
	write(L),
	print_line(Rest).

%getPiece(+Board, +Row, +Column, -Piece)
getPiece([BoardLine | _], 0, Column, Piece):-
	getPieceFromLine(BoardLine, Column, Piece).
getPiece([_|BoardLines], Row, Column, Piece) :-
	Aux is Row - 1,
	getPiece(BoardLines, Aux, Column, Piece).
%getPiece(+BoardLine, +Column, -Piece)
getPieceFromLine([BoardPosition|_], 0, BoardPosition).
getPieceFromLine([_|BoardPositions], Column, Piece) :-
	Aux is Column - 1,
	getPieceFromLine(BoardPositions, Aux, Piece).