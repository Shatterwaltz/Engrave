extends Control
class_name DialogueBox

signal display_finished

var lines: Array[String] = []
var current_line: String = ""
@export var type_time: float = 0.035
var type_time_remaining: float = 0
var typing: bool = false
var typing_index: int = 1

@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel

func _ready():
	DialogueManager.dialogue_box = self
	display_finished.connect(DialogueManager._on_display_finished)

func display_dialogue(p_lines: Array[String]):
	lines = p_lines
	advance_text()

func advance_text():
	if typing:
		typing = false
		rich_text_label.text = current_line
	elif lines.size() > 0:
		current_line = lines.pop_front()
		typing_index = 1
		typing = true
	else:
		rich_text_label.text = ""
		typing = false
		lines = []
		current_line = ""
		display_finished.emit()

func _process(_delta):
	if typing:
		if type_time_remaining > 0:
			type_time_remaining -= _delta
		else:
			type_time_remaining = type_time
			type_next_character()

func type_next_character():
	if typing_index <= current_line.length():
		rich_text_label.text = current_line.left(typing_index)
		match current_line[typing_index - 1]:
			'.': type_time_remaining = .15
			'?': type_time_remaining = .15
			'!': type_time_remaining = .15
		typing_index += 1
	else:
		typing = false

func _unhandled_input(_event):
	if GameState.game_state == Enums.GameStates.DIALOGUE:
		if Input.is_action_just_pressed("confirm"):
			advance_text()
