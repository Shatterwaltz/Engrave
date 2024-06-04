extends Node
@onready var interactable: Interactable = $Interactable

func _ready():
	interactable.interaction_triggered.connect(_on_interact)

func _on_interact():
	print("Oh, I've been interacted...?")
	interactable.interaction_type = Enums.InteractionType.TAKE
