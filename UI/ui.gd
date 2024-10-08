extends Node
class_name UI

@onready var interact_prompt: TextureRect = $InteractPrompt
@onready var dialogue_box = $DialogueBox
@onready var dialogue_box_alter = $DialogueBox/DialogueBoxAlter
@onready var inventory = $Inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.dialogue_box = dialogue_box
	DialogueManager.dialogue_box_alter = dialogue_box_alter
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _unhandled_input(_event):
	if Input.is_action_just_pressed("pause"):
		toggle_pause_game()

func toggle_pause_game():
	if GameState.game_state == Enums.GameStates.ACTIVE:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		GameState.set_game_state(Enums.GameStates.PAUSE)
		inventory.visible = true
	elif GameState.game_state == Enums.GameStates.PAUSE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		GameState.set_game_state(Enums.GameStates.ACTIVE)
		inventory.visible = false
