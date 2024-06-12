extends Node
@onready var interactable: Interactable = $Interactable

func _ready():
	interactable.interaction_triggered.connect(_on_interact)

func _on_interact():
	DialogueManager.display_dialogue(["Just checking if this works...", "Can you hear me?"])
	DialogueManager.display_finished.connect(_on_lines_finish, 4)

func _on_lines_finish():
	DialogueManager.end_dialogue()
