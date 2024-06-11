extends Control
class_name DialogueBox

signal display_finished

var lines: Array[String] = []
@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel

func _ready():
	DialogueManager.dialogue_box = self
	display_finished.connect(DialogueManager._on_display_finished)

func display_dialogue(p_lines: Array[String]):
	lines = p_lines
	rich_text_label.text = lines.pop_front()

func advance_text():
	if lines.size() > 0:
		rich_text_label.text = lines.pop_front()
	else:
		display_finished.emit()

func _unhandled_input(_event):
	if GameState.game_state == Enums.GameStates.DIALOGUE:
		if Input.is_action_just_pressed("confirm") || Input.is_action_just_pressed("interact"):
			advance_text()
