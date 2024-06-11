extends TextureRect

const EXAMINE: Texture2D = preload("res://Assets/UI/examine.png")
const INTERACT_SPEAK: Texture2D = preload("res://Assets/UI/interact_speak.png")
const INTERACT_TAKE: Texture2D = preload("res://Assets/UI/interact_take.png")

var previous_interaction_type: Enums.InteractionType = Enums.InteractionType.SPEAK

func set_interaction_type(interaction_type: Enums.InteractionType):
	if previous_interaction_type != interaction_type:
		match interaction_type:
			Enums.InteractionType.SPEAK:
				texture = INTERACT_SPEAK
			Enums.InteractionType.EXAMINE:
				texture = EXAMINE
			Enums.InteractionType.TAKE:
				texture = INTERACT_TAKE
		previous_interaction_type = interaction_type
	visible = true

func clear_interaction():
	visible = false
