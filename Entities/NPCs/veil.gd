extends Node
@onready var interactable: Interactable = $Interactable

var c1: Conversation = Conversation.new()
var c2: Conversation = Conversation.new()
var c3: Conversation = Conversation.new()
var c4: Conversation = Conversation.new()
var c5: Conversation = Conversation.new()
var c6: Conversation = Conversation.new()

func _ready():
	interactable.interaction_triggered.connect(_on_interact)
	c1.dialogue = ["Just checking if this works...", "Can you hear me?"]
	c1.next_conversation = [c2]
	c2.is_choice = true
	c2.dialogue = ["Yes.", "No.", "I lied, actually."]
	c2.flag_reqs = ["", "", "lied_to_veil"]
	c2.next_conversation = [c3, c4, c5]
	c3.dialogue = ["Excellent!"]
	c4.dialogue = []
	c4.flag_to_set = "lied_to_veil"
	c5.dialogue = ["Why would you even bother doing that for something so trivial?"]
	c5.next_conversation = [c6]
	c6.is_choice = true
	c6.dialogue = ["Felt like it.", "I wasn't sure if I should be honest."]
func _on_interact():
	DialogueManager.conversation_finished.connect(_on_lines_finish, 4)
	DialogueManager.option_selected.connect(_on_choice_made, 4)
	DialogueManager.begin_conversation(c1, Enums.Character.VEIL)

func _on_choice_made(_choice_id: int, choice_text: String):
	print("hmm")
	if _choice_id ==0 && choice_text == "Yes.":
		GameState.add_to_inventory(preload("res://UI/Inventory/ItemIcon.tscn").instantiate())

func _on_lines_finish():
	pass
