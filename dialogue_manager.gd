extends Node

signal option_selected(option_id: int, option_text: String)
signal conversation_finished

var current_conversation: Conversation = null

# Assigned by UI at load time
var dialogue_box: DialogueBox

func begin_conversation(conversation: Conversation):
	current_conversation = conversation
	if !conversation.is_choice:
		_display_dialogue(conversation.dialogue)
	else:
		_display_options(conversation.dialogue)

func _display_dialogue(lines: Array[String]):
	GameState.set_game_state(Enums.GameStates.DIALOGUE)
	dialogue_box.visible = true
	dialogue_box.display_dialogue(lines)

func _display_options(option_list: Array[String]):
	dialogue_box.visible = true
	dialogue_box.display_options(option_list)

func _on_display_finished():
	if current_conversation.next_conversation.size() > 0:
		begin_conversation(current_conversation.next_conversation[0])
	else:
		end_dialogue()

func _on_choice_made(choice_id: int, choice_text: String):
	print("%s - %s" % [choice_id, choice_text])
	option_selected.emit(choice_id, choice_text)
	if current_conversation.next_conversation.size() > 0 && current_conversation.next_conversation[choice_id] != null:
		begin_conversation(current_conversation.next_conversation[choice_id])
	else:
		end_dialogue()

func end_dialogue():
	GameState.set_game_state(Enums.GameStates.ACTIVE)
	dialogue_box.visible = false
	conversation_finished.emit()
	
