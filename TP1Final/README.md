# Emulsion Grupo 2 Turma 1

## Integrantes:
Carolina Rosemback Guilhermino - up201800171@fe.up.pt

José Pedro Nogueira Rodrigues - up201708806@fe.up.pt

## Instalação e Execução:
* Instalar SICStus Prolog;
* File > Consult > Selecionar o ficheiro 'emulsion.pl';
* Inserir 'play.' para inicializar o jogo.


## Descrição do Jogo:
Emulsion é um jogo de território finito para 2 jogadores: Preto e Branco. O objetivo do jogo é obter um maior score na posição final. O score é calculado pelo tamanho de seu maior grupo de peças.
Um grupo é formado por peças da mesma cor ortogonalmente adjacentes.

## Regras do Jogo:
As peças pretas começam primeiro, depois os turnos vão se alternando. Em cada ronda, deve-se trocar as posições de duas peças de diferentes cores, ortogonalmente ou na diagonal, para que o valor da sua peça no par aumente.

O valor de uma peça é dado pelo número de peças da mesma cor, ortogonalmente adjacentes a ela, mais metade do número de arestas do tabuleiro adjacentes à peça.

Se houver empate, cada jogador adiciona ao score o tamanho do seu segundo maior grupo. Se o empate seguir-se, então o terceiro maior grupo é levado em conta e assim sucessivamente enquanto o empate acontecer. Caso o tabuleiro seja de tamanho par, se está empatado até o último grupo, quem tiver feito o último movimento é o vencedor.

O tamanho do tabuleiro, segundo o jogo original, pode ser de qualquer tamanho. Por enquanto, o nosso projeto utiliza um tabuleiro de dimensão fixa de 10x10.

### Ligações usadas na recolha de informação:
  + [Página oficial do jogo](https://boardgamegeek.com/boardgame/311851/emulsion)
  + Contacto com o autor do jogo
    <details>
    <summary>Conversa:</summary>
    <img src="/TP1Final/images/msg1.png" alt="Message 1">
    <img src="/TP1Final/images/msg2.png" alt="Message 2">
  </details>

## Representação Interna:
 - ### Representação do estado do jogo:
    A representação do estado do jogo é representada por uma lista de listas de *posições* (**board**), mas que é encabeçada por um *player* (**player**), sendo esse *player* o jogador que é próximo a jogar.
    
    O *player* é representado por um número, que pode ser:
    
    (1) - O jogador 1 humano;
    
    (2) - O jogador 2 humano;
    
    (-1) - O jogador 1 computador;
    
    (-2) - O jogador 2 computador.
    
      ```prolog
      %gameState(+Player, +Board, -GameState)
      gameState(Player, Board, GameState) :-
      append([Player], Board, GameState).
      
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
      ```

## Visualização do Estado do Jogo:

### Predicados de desenho do estado de jogo:

- **display_game(+GameState, +CurrentPlayer)**: 
  O predicado **display_game** recebe um estado de jogo e qual o próximo jogador a jogar, e chama o predicado **printBoard**.
  
  	```prolog
     	%display_game(+GameState, +CurrentPlayer)
		display_game([_|Board], _) :-
		printBoard(Board).
	```

- **printBoard(+Board)**: 
  O predicado **printBoard** recebe o tabuleiro e vai depois chamar o predicato **printPreBoard** e depois o predicado **printActualBoard**.
  
  	```prolog
     	%printBoard(+Board)
		printBoard(Board) :-
		printPreBoard,
		printActualBoard(Board, 0),
		nl, nl.
	```
  
- **printPreBoard**: 
  O predicado **printPreBoard** vai desenhar a informação que antecede o desenho do tabuleiro atual.
  
  	```prolog
     	%printPreBoard
		printPreBoard :-
		nl,nl,
		write('-=x=-=x=-=x=-=x=- Emulsion -=x=-=x=-=x=-=x=-'),
		nl,nl,nl,
		write('    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |'),
		nl.
	```

- **printActualBoard(+Board, +LineNumber)**: 
  O predicado **printBoard** recebe uma parte do tabuleiro e o número da linha desse estado que irá desenhar, e por cada linha irá escrever o número da linha e de seguida chamar o predicado **printLine**, chamando-se a si própria a seguir, recursivamente, até terminar de desenhar todas as linhas do tabuleiro.
  
  	```prolog
     	%printActualBoard(+Board, +LineNumber)
		printActualBoard([], 10) :-
		write(' ------------------------------------------- ').
		printActualBoard([FirstLine|Rest], N) :-
		write(' ------------------------------------------- '),
		nl,
		write('  '),
		write(N),
		write(' '),
		N1 is N + 1,
		printLine(FirstLine),
		nl,
		printActualBoard(Rest, N1).
	```
  
- **printLine(+BoardLine)**: 
  O predicado **printLine** recebe uma linha do tabuleiro e vai-se chamando recursivamente até terminar de desenhar essa linha, chamando o predicado **pieceRep** para saber como desenhar cada posição.
  
  	```prolog
     	%printLine(+BoardLine)	
		printLine([]) :-
		write('|').
		printLine([FirstSpot|Rest]) :-
		pieceRep(FirstSpot, L),
		write(L),
		printLine(Rest).
	```

### Menu
 <img src="/TP1Final/images/menu.png" alt="Menu">

 Para inicializar o jogo, é utilizado o predicado **mainMenu**, que por sua vez chama os restantes predicados.

```prolog
	%mainMenu
	mainMenu :-
	printMainMenu,
	getMenuOption,
	read(Input),
	menuOption(Input).
``` 

  Nas opções de jogo, encontram-se: *Humano Vs Humano*, *Humano Vs Máquina* e *Máquina Vs Máquina*, que são dadas respectivamentes pelos numero, 1, 2 e 3, além da opção de saída. 
  No menu, pede-se qual modo de jogo o jogador quer através de **getMenuOption**. O predicado **menuOption** efetua o processamento do input, redirecionando o jogador para o modo selecionado.
  Caso o input seja um valor inválido, é mostrado ao jogador uma mensagem de erro e é pedido outro input, até ser dado um input válido.

### Jogadas Válidas
Para a obtenção das jogadas válidas para o estado de jogo atual, foi implementado o predicado **valid_moves**, que dado um estado de jogo e um jogador, vai percorrer o tabuleiro e vai fazer uma lista de todas as posições que contém uma peça, da cor do jogador, que ainda tem jogadas legais possíveis.

  ```prolog
  	%valid_moves(+GameState, +Player, -ListOfMoves)
	valid_moves([_|Board], Player, ListOfMoves) :-
	positionsList(ListOfPositions),
	getPieceType(Player, PieceType),
	valid_movesAux(Board, Player, Board, 9, ListOfPositions, PieceType, [], ListOfMoves).
  ```

Depois de obtida essa lista, e ser pedido ao jogador que selecione uma das peças que pode selecionar (que tem jogadas válidas), iremos então utilizar o predicado **validMovesOnPosition**, que dado o estado de jogo, a linha e coluna da peça selecionada, um indicador da fase em que a função se encontra e a cor da peça selecionada, vai devolver uma lista de todos os movimentos legais para essa peça.

  ```prolog
%validMovesOnPosition(+GameState, +Row, +Column, +PositionToCheck, +PieceType, +PlaceHolderList, -ListOfValidMoves)
%PositionToCheck: 1 - TopLeft \ 2 - Top \ 3 - TopRight \ 4 - Right \ 5 - BottomRight \ 6 - Bottom \ 7 - BottomLeft \ 8 - Left \ 9 - Finish function
validMovesOnPosition(_, _, _, 9, _, PlaceHolderList, ListOfValidMoves) :-
	ListOfValidMoves = PlaceHolderList.
validMovesOnPosition([Player|Board], Row, Column, 1, PieceType, PlaceHolderList, ListOfValidMoves) :-
	RowToCheck is Row - 1,
	ColumnToCheck is Column - 1,
	RowToCheck >= 0,
	RowToCheck =< 9,
	ColumnToCheck >= 0,
	ColumnToCheck =< 9,
	getReversePieceType(PieceType, ReversePieceType),
	getPiece(Board, RowToCheck, ColumnToCheck, Piece),!,
	Piece == ReversePieceType,
	createMove(Row, Column, RowToCheck, ColumnToCheck, MoveToCheck),
	move([Player|Board], MoveToCheck, [_|NewBoard]),
	pieceValue([Player|Board], Row, Column, PieceType, 1, OldValue1),!,
	pieceValue([Player|NewBoard], RowToCheck, ColumnToCheck, PieceType, 1, NewValue1),!,
	NewValue1 > OldValue1 ->
	pieceValue([Player|Board], RowToCheck, ColumnToCheck, ReversePieceType, 1, OldValue2),!,
	pieceValue([Player|NewBoard], Row, Column, ReversePieceType, 1, NewValue2),!,
	NewValue2 > OldValue2 ->
	append([[RowToCheck,ColumnToCheck]], PlaceHolderList, Aux),
	validMovesOnPosition([Player|Board], Row, Column, 2, PieceType, Aux, ListOfValidMoves);
	validMovesOnPosition([Player|Board], Row, Column, 2, PieceType, PlaceHolderList, ListOfValidMoves).
validMovesOnPosition([Player|Board], Row, Column, 2, PieceType, PlaceHolderList, ListOfValidMoves) :-
	RowToCheck is Row - 1,
	ColumnToCheck is Column,
	RowToCheck >= 0,
	RowToCheck =< 9,
	ColumnToCheck >= 0,
	ColumnToCheck =< 9,
	getReversePieceType(PieceType, ReversePieceType),
	getPiece(Board, RowToCheck, ColumnToCheck, Piece),!,
	Piece == ReversePieceType,
	createMove(Row, Column, RowToCheck, ColumnToCheck, MoveToCheck),
	move([Player|Board], MoveToCheck, [_|NewBoard]),
	pieceValue([Player|Board], Row, Column, PieceType, 1, OldValue1),!,
	pieceValue([Player|NewBoard], RowToCheck, ColumnToCheck, PieceType, 1, NewValue1),!,
	NewValue1 > OldValue1 ->
	pieceValue([Player|Board], RowToCheck, ColumnToCheck, ReversePieceType, 1, OldValue2),!,
	pieceValue([Player|NewBoard], Row, Column, ReversePieceType, 1, NewValue2),!,
	NewValue2 > OldValue2 ->
	append([[RowToCheck,ColumnToCheck]], PlaceHolderList, Aux),
	validMovesOnPosition([Player|Board], Row, Column, 3, PieceType, Aux, ListOfValidMoves);
	validMovesOnPosition([Player|Board], Row, Column, 3, PieceType, PlaceHolderList, ListOfValidMoves).
validMovesOnPosition([Player|Board], Row, Column, 3, PieceType, PlaceHolderList, ListOfValidMoves) :-
	RowToCheck is Row - 1,
	ColumnToCheck is Column + 1,
	RowToCheck >= 0,
	RowToCheck =< 9,
	ColumnToCheck >= 0,
	ColumnToCheck =< 9,
	getReversePieceType(PieceType, ReversePieceType),
	getPiece(Board, RowToCheck, ColumnToCheck, Piece),!,
	Piece == ReversePieceType,
	createMove(Row, Column, RowToCheck, ColumnToCheck, MoveToCheck),
	move([Player|Board], MoveToCheck, [_|NewBoard]),
	pieceValue([Player|Board], Row, Column, PieceType, 1, OldValue1),!,
	pieceValue([Player|NewBoard], RowToCheck, ColumnToCheck, PieceType, 1, NewValue1),!,
	NewValue1 > OldValue1 ->
	pieceValue([Player|Board], RowToCheck, ColumnToCheck, ReversePieceType, 1, OldValue2),!,
	pieceValue([Player|NewBoard], Row, Column, ReversePieceType, 1, NewValue2),!,
	NewValue2 > OldValue2 ->
	append([[RowToCheck,ColumnToCheck]], PlaceHolderList, Aux),
	validMovesOnPosition([Player|Board], Row, Column, 4, PieceType, Aux, ListOfValidMoves);
	validMovesOnPosition([Player|Board], Row, Column, 4, PieceType, PlaceHolderList, ListOfValidMoves).
validMovesOnPosition([Player|Board], Row, Column, 4, PieceType, PlaceHolderList, ListOfValidMoves) :-
	RowToCheck is Row,
	ColumnToCheck is Column + 1,
	RowToCheck >= 0,
	RowToCheck =< 9,
	ColumnToCheck >= 0,
	ColumnToCheck =< 9,
	getReversePieceType(PieceType, ReversePieceType),
	getPiece(Board, RowToCheck, ColumnToCheck, Piece),!,
	Piece == ReversePieceType,
	createMove(Row, Column, RowToCheck, ColumnToCheck, MoveToCheck),
	move([Player|Board], MoveToCheck, [_|NewBoard]),
	pieceValue([Player|Board], Row, Column, PieceType, 1, OldValue1),!,
	pieceValue([Player|NewBoard], RowToCheck, ColumnToCheck, PieceType, 1, NewValue1),!,
	NewValue1 > OldValue1 ->
	pieceValue([Player|Board], RowToCheck, ColumnToCheck, ReversePieceType, 1, OldValue2),!,
	pieceValue([Player|NewBoard], Row, Column, ReversePieceType, 1, NewValue2),!,
	NewValue2 > OldValue2 ->
	append([[RowToCheck,ColumnToCheck]], PlaceHolderList, Aux),
	validMovesOnPosition([Player|Board], Row, Column, 5, PieceType, Aux, ListOfValidMoves);
	validMovesOnPosition([Player|Board], Row, Column, 5, PieceType, PlaceHolderList, ListOfValidMoves).
validMovesOnPosition([Player|Board], Row, Column, 5, PieceType, PlaceHolderList, ListOfValidMoves) :-
	RowToCheck is Row + 1,
	ColumnToCheck is Column + 1,
	RowToCheck >= 0,
	RowToCheck =< 9,
	ColumnToCheck >= 0,
	ColumnToCheck =< 9,
	getReversePieceType(PieceType, ReversePieceType),
	getPiece(Board, RowToCheck, ColumnToCheck, Piece),!,
	Piece == ReversePieceType,
	createMove(Row, Column, RowToCheck, ColumnToCheck, MoveToCheck),
	move([Player|Board], MoveToCheck, [_|NewBoard]),
	pieceValue([Player|Board], Row, Column, PieceType, 1, OldValue1),!,
	pieceValue([Player|NewBoard], RowToCheck, ColumnToCheck, PieceType, 1, NewValue1),!,
	NewValue1 > OldValue1 ->
	pieceValue([Player|Board], RowToCheck, ColumnToCheck, ReversePieceType, 1, OldValue2),!,
	pieceValue([Player|NewBoard], Row, Column, ReversePieceType, 1, NewValue2),!,
	NewValue2 > OldValue2 ->
	append([[RowToCheck,ColumnToCheck]], PlaceHolderList, Aux),
	validMovesOnPosition([Player|Board], Row, Column, 6, PieceType, Aux, ListOfValidMoves);
	validMovesOnPosition([Player|Board], Row, Column, 6, PieceType, PlaceHolderList, ListOfValidMoves).
validMovesOnPosition([Player|Board], Row, Column, 6, PieceType, PlaceHolderList, ListOfValidMoves) :-
	RowToCheck is Row + 1,
	ColumnToCheck is Column,
	RowToCheck >= 0,
	RowToCheck =< 9,
	ColumnToCheck >= 0,
	ColumnToCheck =< 9,
	getReversePieceType(PieceType, ReversePieceType),
	getPiece(Board, RowToCheck, ColumnToCheck, Piece),!,
	Piece == ReversePieceType,
	createMove(Row, Column, RowToCheck, ColumnToCheck, MoveToCheck),
	move([Player|Board], MoveToCheck, [_|NewBoard]),
	pieceValue([Player|Board], Row, Column, PieceType, 1, OldValue1),!,
	pieceValue([Player|NewBoard], RowToCheck, ColumnToCheck, PieceType, 1, NewValue1),!,
	NewValue1 > OldValue1 ->
	pieceValue([Player|Board], RowToCheck, ColumnToCheck, ReversePieceType, 1, OldValue2),!,
	pieceValue([Player|NewBoard], Row, Column, ReversePieceType, 1, NewValue2),!,
	NewValue2 > OldValue2 ->
	append([[RowToCheck,ColumnToCheck]], PlaceHolderList, Aux),
	validMovesOnPosition([Player|Board], Row, Column, 7, PieceType, Aux, ListOfValidMoves);
	validMovesOnPosition([Player|Board], Row, Column, 7, PieceType, PlaceHolderList, ListOfValidMoves).
validMovesOnPosition([Player|Board], Row, Column, 7, PieceType, PlaceHolderList, ListOfValidMoves) :-
	RowToCheck is Row + 1,
	ColumnToCheck is Column - 1,
	RowToCheck >= 0,
	RowToCheck =< 9,
	ColumnToCheck >= 0,
	ColumnToCheck =< 9,
	getReversePieceType(PieceType, ReversePieceType),
	getPiece(Board, RowToCheck, ColumnToCheck, Piece),!,
	Piece == ReversePieceType,
	createMove(Row, Column, RowToCheck, ColumnToCheck, MoveToCheck),
	move([Player|Board], MoveToCheck, [_|NewBoard]),
	pieceValue([Player|Board], Row, Column, PieceType, 1, OldValue1),!,
	pieceValue([Player|NewBoard], RowToCheck, ColumnToCheck, PieceType, 1, NewValue1),!,
	NewValue1 > OldValue1 ->
	pieceValue([Player|Board], RowToCheck, ColumnToCheck, ReversePieceType, 1, OldValue2),!,
	pieceValue([Player|NewBoard], Row, Column, ReversePieceType, 1, NewValue2),!,
	NewValue2 > OldValue2 ->
	append([[RowToCheck,ColumnToCheck]], PlaceHolderList, Aux),
	validMovesOnPosition([Player|Board], Row, Column, 8, PieceType, Aux, ListOfValidMoves);
	validMovesOnPosition([Player|Board], Row, Column, 8, PieceType, PlaceHolderList, ListOfValidMoves).
validMovesOnPosition([Player|Board], Row, Column, 8, PieceType, PlaceHolderList, ListOfValidMoves) :-
	RowToCheck is Row,
	ColumnToCheck is Column - 1,
	RowToCheck >= 0,
	RowToCheck =< 9,
	ColumnToCheck >= 0,
	ColumnToCheck =< 9,
	getReversePieceType(PieceType, ReversePieceType),
	getPiece(Board, RowToCheck, ColumnToCheck, Piece),!,
	Piece == ReversePieceType,
	createMove(Row, Column, RowToCheck, ColumnToCheck, MoveToCheck),
	move([Player|Board], MoveToCheck, [_|NewBoard]),
	pieceValue([Player|Board], Row, Column, PieceType, 1, OldValue1),!,
	pieceValue([Player|NewBoard], RowToCheck, ColumnToCheck, PieceType, 1, NewValue1),!,
	NewValue1 > OldValue1 ->
	pieceValue([Player|Board], RowToCheck, ColumnToCheck, ReversePieceType, 1, OldValue2),!,
	pieceValue([Player|NewBoard], Row, Column, ReversePieceType, 1, NewValue2),!,
	NewValue2 > OldValue2 ->
	append([[RowToCheck,ColumnToCheck]], PlaceHolderList, Aux),
	validMovesOnPosition([Player|Board], Row, Column, 9, PieceType, Aux, ListOfValidMoves);
	validMovesOnPosition([Player|Board], Row, Column, 9, PieceType, PlaceHolderList, ListOfValidMoves).
  ```

### Execução de Movimentos
Para realizar os movimentos, foi implementado o predicado **move**, que dado um estado de jogo e o movimento a executar, vai processar a informação e gerar um novo estado de jogo que vai conter o movimento concluído.

```prolog
%move(+GameState, +Move, -NewGameState)​
move([NextPlayer|Board], [[OldRow, OldColumn], [NewRow, NewColumn]], NewGameState) :-
	changePiece(Board, OldRow, OldColumn, NewBoard1),
	changePiece(NewBoard1, NewRow, NewColumn, NewBoard2),
	NewGameState = [NextPlayer|NewBoard2].
```

### Final do Jogo
O jogo termina quando não existe mais nenhuma jogada legal possível. Quando isso ocorre, o predicado **game_over** chama o predicado **checkWinner**, que pega na pontuação do maior bloco de peças de cada jogador, chamando em seguida o predicado **getWinner**, que irá realizar a comparação das pontuações dos jogadores e determinar o vencedor.

```prolog
%game_over(+GameState, -Winner)
game_over([Player|Board], Winner) :-
	checkIfGameIsOver([Player|Board]),
	write('-=!=-=!=-=!=-=!=- Game Over -=!=-=!=-=!=-=!=-\n'),
    	checkWinner([Player|Board], Winner),
	write('\n              \\\\\\   Winner   ///\n'),
	format('\n                    ~w~n', Winner),
	write('\n              ///   Winner   \\\\\\\n');
	Winner = 'none'.
``` 

### Computação dos Valores das Peças
Para avaliar a pontuação de cada jogador num dado momento, é usado o predicado **value([_|Board], Player, Value)**, que dado um estado de jogo e o jogador em questão, devolve o valor do maior grupo de peças da sua cor existente no atual estado de jogo.

```prolog
%value(+GameState, +Player, -Value)​
value([_|Board], Player, Value) :-
	positionsList(ListOfPositions),
	getPieceType(Player, PieceType),
	getLargestGroup(Board, ListOfPositions, [], PieceType, 0, MaxValue),
	Value = MaxValue.
```

Para avaliar o valor de uma peça específica, foi criado o predicado **pieceValue**, que dado um estado de jogo, uma linha e uma coluna, e a cor da peça, devolve o valor dessa peça.

```prolog
%pieceValue(+GameState, +PieceRow, +PieceColumn, +PieceType, +IsMasterFunction, -Value)
pieceValue([_|Board], PieceRow, PieceColumn, PieceType, 1, Value) :-
	getPiece(Board, PieceRow, PieceColumn, Piece),!,
	Piece == PieceType ->
	AuxTop is PieceRow-1,
	AuxBottom is PieceRow+1,
	AuxLeft is PieceColumn-1,
	AuxRight is PieceColumn+1,
	pieceValue([_|Board], PieceRow, PieceColumn, PieceType, -1, BoardEdgesValue),
	pieceValue([_|Board], AuxTop, PieceColumn, PieceType, 0, Aux1),
	pieceValue([_|Board], PieceRow, AuxRight, PieceType, 0, Aux2),
	pieceValue([_|Board], AuxBottom, PieceColumn, PieceType, 0, Aux3),
	pieceValue([_|Board], PieceRow, AuxLeft, PieceType, 0, Aux4),
	Value is BoardEdgesValue + Aux1 + Aux2 + Aux3 + Aux4;
	Value = 0.
pieceValue([_|Board], PieceRow, PieceColumn, PieceType, 0, Value) :-
	PieceRow >= 0,
	PieceRow =< 9,
	PieceColumn >= 0,
	PieceColumn =< 9,
	getPiece(Board, PieceRow, PieceColumn, Piece),!,
	Piece == PieceType ->
	Value = 1;
	Value = 0.
pieceValue([_|_], PieceRow, PieceColumn, _, -1, Value) :-
	AuxTop is PieceRow-1,
	AuxRight is PieceColumn+1,
	member(AuxTop, [-1, 10]),
	member(AuxRight, [-1, 10]),
	Value = 1;
	AuxTop is PieceRow-1,
	AuxLeft is PieceColumn-1,
	member(AuxTop, [-1, 10]),
	member(AuxLeft, [-1, 10]),
	Value = 1;
	AuxBottom is PieceRow+1,
	AuxRight is PieceColumn+1,
	member(AuxBottom, [-1, 10]),
	member(AuxRight, [-1, 10]),
	Value = 1;
	AuxBottom is PieceRow+1,
	AuxLeft is PieceColumn-1,
	member(AuxBottom, [-1, 10]),
	member(AuxLeft, [-1, 10]),
	Value = 1;
	AuxTop is PieceRow-1,
	member(AuxTop, [-1, 10]),
	Value = 0.5;
	AuxBottom is PieceRow+1,
	member(AuxBottom, [-1, 10]),
	Value = 0.5;
	AuxLeft is PieceColumn-1,
	member(AuxLeft, [-1, 10]),
	Value = 0.5;
	AuxRight is PieceColumn+1,
	member(AuxRight, [-1, 10]),
	Value = 0.5;
	Value = 0.
```

### Jogadas do Bot/Computador
Para permitir ao computador de ser um ou ambos os players, foi necessária a criação do predicado **choose_move**, que recebendo o estado de jogo e o jogador que é, cria um movimento legal para a seguir ser executado.

```prolog
%choose_move(+GameState, +Player, +Level, -Move)
choose_move([_|Board], Player, _, Move) :-
	valid_moves([_|Board], Player, ListOfMoves),
	random_member([OldRow, OldColumn], ListOfMoves),
	getPieceType(Player, PieceType),
	validMovesOnPosition([Player|Board], OldRow, OldColumn, 1, PieceType, [], ListOfValidMoves),
	random_member([NewRow, NewColumn], ListOfValidMoves),
	createMove(OldRow, OldColumn, NewRow, NewColumn, Move).
``` 

### Conclusões 
Ao longo do projeto, foram encontradas algumas dificuldades, nomeadamente, pensamento recursivo e a estruturação do código, funcionamento geral do jogo e escolhas a tomar em relação ao funcionamento dos predicados. Eventualmente, conseguimos superá-las, resultando neste projeto que consideramos por agora concluído.

#### Known Issues
* Ficou por implementar o processamento do vencedor caso o maior grupo de ambos os jogadores seja igual, resultando apenas em empate.
* Ficou por implementar a existência de dificuldades diferentes para o bot, apenas existe uma.

#### Roadmap
Para além da resolução do que ficou por implementar no jogo, há bastantes melhorias possíveis em termos da eficiência dos predicados e da sua organização de código e nos ficheiros respetivos.

### Bibliografia
* Documentação do SICStus
* Slides do Moodle
* [StackOverflow](https://stackoverflow.com/)
* [Página oficial do jogo](https://boardgamegeek.com/boardgame/311851/emulsion)
* Conversa por chat com o [criador do jogo](https://boardgamegeek.com/boardgamedesigner/47001/luis-bolanos-mures)

### Imagens do jogo

|    Initial    |  Intermediate  |     Final     |
|:-------------:|:--------------:|:-------------:|
|![Initial Image](/TP1Final/images/initial.png)|![Intermediate Image](/TP1Final/images/intermediate.png)|![Final Image](/TP1Final/images/final.png)|
