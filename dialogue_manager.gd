extends Node

signal display_finished

# Assigned by UI at load time
var dialogue_box: DialogueBox

func begin_dialogue():
	GameState.set_game_state(Enums.GameStates.DIALOGUE)
	dialogue_box.visible = true

func display_dialogue(lines: Array[String]):
	dialogue_box.display_dialogue(lines)

func _on_display_finished():
	display_finished.emit()

func end_dialogue():
	GameState.set_game_state(Enums.GameStates.ACTIVE)
	dialogue_box.visible = false
	
