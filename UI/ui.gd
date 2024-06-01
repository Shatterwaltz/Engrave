extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _unhandled_input(_event):
	if Input.is_action_just_pressed("pause"):
		pause_game()

func pause_game():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().quit()
