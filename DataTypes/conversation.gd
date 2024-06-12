extends Resource
class_name Conversation

@export var is_choice: bool
@export var dialogue: Array[String]
@export var next_conversation: Array[Conversation]
