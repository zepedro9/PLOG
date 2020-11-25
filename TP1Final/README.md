# Emulsion Grupo 2 Turma 1

## Integrantes:
Carolina Rosemback Guilhermino - up201800171@fe.up.pt

José Pedro Nogueira Rodrigues - up201708806@fe.up.pt

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
    <img src="/TP1Intermediate/images/msg1.png" alt="Message 1">
    <img src="/TP1Intermediate/images/msg2.png" alt="Message 2">
  </details>

## Representação Interna:
 - ### Representação do estado do jogo:
    A representação do estado do jogo é representada por uma lista de listas de *posições* (**position**).
      ```python
      %position(+Piece, -Representation)
      position(black, P) :- P='| B '.
      position(white, P) :- P='|   '.
      
      %initial(-GameState)
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
      
      %intermediate(-GameState)
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

      %final(-GameState)
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
      ```
      
 - ### Representação do jogador atual:
      ```python
      %player(-PlayerName, -PlayerID)
      player('Jogador 1', 1).
      player('Jogador 2', 2).

      %get_current_player(-Player, +ID)
      get_current_player(X, N) :-
        player(X, N).
      ```

## Visualização do Estado do Jogo:

### Predicado de desenho do estado de jogo:

- **display_game(+GameState, +CurrentPlayer)**: 
  O predicado **display_game** recebe um estado de jogo e qual o próximo jogador a jogar, começa por limpar o ecrã com a função **clear_screen**, e depois começa a desenhar o título do jogo e a númeração das colunas, chamando de seguida o predicado **print_board** e o predicado **print_next_move_request**.

- **print_board(+GameState, +LineNumber)**: 
  O predicado **print_board** recebe uma parte do estado do jogo e o número da linha desse estado que irá desenhar, e por cada linha irá escrever o número da linha e de seguida chamar o predicado **print_line**, chamando-se a si própria a seguir, recursivamente, até terminar de desenhar todas as linhas do tabuleiro.
  
- **print_line(+GameStateLine)**: 
  O predicado **print_line** recebe uma linha do estado do jogo e vai-se chamando recursivamente até terminar de desenhar essa linha, chamando o predicado **position** para saber como desenhar cada posição.

- **print_next_move_request(+CurrentPlayer)**: 
  O predicado **print_next_move_request** recebe qual o próximo jogador a jogar e imprime o texto que irá anteceder o pedido sobre qual o movimento que o jogador em questão quer executar a seguir.
  

    ```python
    %display_game(+GameState, +CurrentPlayer)
    display_game(Initial, P) :-
      clear_screen,
      write('-=x=-=x=-=x=-=x=-=x=-=x=-=x=- Emulsion -=x=-=x=-=x=-=x=-=x=-=x=-=x=-'),
      nl,nl,nl,
      write('    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |'),
      nl,
      print_board(Initial, 0),
      print_next_move_request(P).

    %print_next_move_request(+CurrentPlayer)
    print_next_move_request(P) :-
      nl,nl,
      write('E a vez do '),
      write(P),
      write('!'),
      nl,
      write('Choose your next move: ').

    %print_board(+GameState, +LineNumber)
    print_board([], 10) :-
      write('     _______________________________________ ').
    print_board([FirstLine|Rest], N) :-
      write('     _______________________________________ '),
      nl,
      write('| '),
      write(N),
      write(' '),
      N1 is N + 1,
      print_line(FirstLine),
      nl,
      print_board(Rest, N1).

    %print_line(+GameStateLine)	
    print_line([]) :-
      write('|').
    print_line([FirstSpot|Rest]) :-
      position(FirstSpot, L),
      write(L),
      print_line(Rest).
    ```

### Implementamos, para visualização do estado do jogo, três estados diferentes:
- **Initial**: 
  Este é o estado inicial do jogo, em que todas as posições do tabuleiro são inicializadas com peças pretas e brancas num padrão de xadrez.
  
- **Intermediate**: 
  Este é um estado intermédio do jogo, em que já foram executados vários movimentos das peças por ambos os jogadores.
  
- **Final**: 
  Este é um estado final do jogo, em que não existem mais movimentos legais, pelo que o jogo de **Emulsion** está terminado, ganho pelas peças pretas (55 vs 45).

|    Initial    |  Intermediate  |     Final     |
|:-------------:|:--------------:|:-------------:|
|![Initial Image](/TP1Intermediate/images/initial.png)|![Intermediate Image](/TP1Intermediate/images/intermediate.png)|![Final Image](/TP1Intermediate/images/final.png)|
