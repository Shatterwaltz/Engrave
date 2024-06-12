extends Node

signal option_selected(option_id: int, option_text: String)
signal conversation_finished
var current_conversation: Conversation = null
var current_speaker: Enums.Character = Enums.Character.SYSTEM

# Assigned by UI at load time
var dialogue_box: DialogueBox

@export var speaker_texture_map: Dictionary = {
	Enums.Character.SYSTEM: preload("res://Assets/UI/dialogue_box.png"),
	Enums.Character.VEIL: preload("res://Assets/UI/dialogue_box_veil.png")
}

func begin_conversation(conversation: Conversation, speaker: Enums.Character = Enums.Character.SYSTEM):
	current_conversation = conversation
	current_speaker = speaker
	dialogue_box.texture = speaker_texture_map[speaker]
	if conversation.flag_to_set:
		GameState.set_flag(conversation.flag_to_set)
	if !conversation.is_choice:
		_display_dialogue(conversation.dialogue)
	else:
		_display_options(conversation.dialogue)

func _display_dialogue(lines: Array[String]):
	GameState.set_game_state(Enums.GameStates.DIALOGUE)
	dialogue_box.visible = true
	dialogue_box.display_dialogue(lines)

func _display_options(option_list: Array[String]):
	var options_available: Array[String] = []
	if !current_conversation.flag_reqs:
		options_available = option_list
	else:
		for i in range(option_list.size()):
			if !current_conversation.flag_reqs[i] || GameState.check_flag(current_conversation.flag_reqs[i]):
				options_available.append(option_list[i])
	dialogue_box.visible = true
	dialogue_box.display_options(options_available)

func _on_display_finished():
	var next_conversation: Array[Conversation] = current_conversation.next_conversation
	if next_conversation.size() > 0 && (!current_conversation.flag_reqs || GameState.check_flag(current_conversation.flag_reqs[0])):
		begin_conversation(current_conversation.next_conversation[0], current_speaker)
	else:
		end_dialogue()

func _on_choice_made(choice_id: int, choice_text: String):
	print("%s - %s" % [choice_id, choice_text])
	option_selected.emit(choice_id, choice_text)
	var next_conversation: Array[Conversation] = current_conversation.next_conversation
	if next_conversation.size() > 0 && next_conversation[choice_id] != null &&\
		(!next_conversation[choice_id].flag_reqs || GameState.check_flag(current_conversation.flag_reqs[choice_id])):
		begin_conversation(current_conversation.next_conversation[choice_id], current_speaker)
	else:
		end_dialogue()

func end_dialogue():
	GameState.set_game_state(Enums.GameStates.ACTIVE)
	dialogue_box.visible = false
	conversation_finished.emit()
	
