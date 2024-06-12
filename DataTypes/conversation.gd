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

#List of flags associated with each conversation option. 
#if flag_reqs[n] is present in gamestate, next_conversation[n] will be available
@export var flag_reqs: Array[String]

#Sets this flag when the conversation is triggered
@export var flag_to_set: String

#Character that is speaking
@export var speaker: Enums.Character
