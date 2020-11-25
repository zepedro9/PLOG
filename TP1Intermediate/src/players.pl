%player(-PlayerName, -PlayerID)
player('Jogador 1', 1).
player('Jogador 2', 2).

%get_current_player(-Player, +PlayerID)
get_current_player(X, N) :-
	player(X, N).
