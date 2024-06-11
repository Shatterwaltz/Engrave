extends Node

signal game_state_changed(new_state: Enums.GameStates)
var game_state: Enums.GameStates = Enums.GameStates.ACTIVE

func set_game_state(new_state: Enums.GameStates):
	game_state = new_state
	game_state_changed.emit(new_state)
