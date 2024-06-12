extends Node
@onready var interactable: Interactable = $Interactable

var c1: Conversation = Conversation.new()
var c2: Conversation = Conversation.new()
var c3: Conversation = Conversation.new()

func _ready():
	interactable.interaction_triggered.connect(_on_interact)
	c1.dialogue = ["Just checking if this works...", "Can you hear me?"]
	c1.next_conversation = [c2]
	c2.is_choice = true
	c2.dialogue = ["Yes.", "No."]
	c2.next_conversation = [c3, null]
	c3.dialogue = ["Excellent!"]

func _on_interact():
	DialogueManager.conversation_finished.connect(_on_lines_finish, 4)
	DialogueManager.begin_conversation(c1)

func _on_choice_made(_choice_id: int, choice_text: String):
	print(choice_text + "was selected")

func _on_lines_finish():
	print("Veil understands the conversation is over.")
