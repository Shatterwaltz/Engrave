extends Resource
class_name Conversation

#Denotes if this conversation is text or a list of options
@export var is_choice: bool

#If is a choice, this will be used as list of options
@export var dialogue: Array[String]

#If not a choice, [0] is automatically run
#If is a choice, dialogue[n] will trigger next_conversation[n]
#Any null value will end the conversation
@export var next_conversation: Array[Conversation]
