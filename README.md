# Emulsion Turma 1 Grupo 2

## Integrantes:
Carolina Rosemback Guilhermino - up201800171@fe.up.pt

José Pedro Nogueira Rodrigues - up201708806@fe.up.pt

## Descrição do Jogo:
Emulsion é um jogo de território finito para 2 jogadores: Preto e Branco. O objetivo do jogo é obter um maior score na posição final. O score é calculado pelo tamanho de seu maior grupo de peças.
Um grupo é formado por peças da mesma cor ortogonalmente adjacentes.

## Regras do Jogo:
As peças pretas pretas começam primeiro, em seguida as vezes se alteram. Em sua vez, deve-se trocar as posições de duas peças de diferentes cores, ortogonalmente ou na diagonal, para que o valor de sua peça no par aumente. 

O valor de uma peça é dado pelo número de de peças da mesma cor, ortogonalmente adjacentes a ela, mais metade do número de arestas do tabuleiro adjacentes à peça.

Se houver empate, cada jogador adiciona ao socre o tamanho do seu segundo maior grupo. Se o empate seguir-se, então o terciero maior grupo é levado em conta e assim sucessivamente enquanto o empate acontecer. Caso o tabuleiro seja de tamanho par, se está empatado até o último grupo, quem tiver feito o último movimento é o ganhador.

## Representação Interna:

## Visualização do Estado do Jogo:
