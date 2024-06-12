extends Node

signal game_state_changed(new_state: Enums.GameStates)
var game_state: Enums.GameStates = Enums.GameStates.ACTIVE

var flags: Dictionary = {}

func set_game_state(new_state: Enums.GameStates):
	game_state = new_state
	game_state_changed.emit(new_state)

func set_flag(flag: String):
	flags[flag] = flag

func check_flag(flag: String) -> bool:
	return flags.has(flag)
