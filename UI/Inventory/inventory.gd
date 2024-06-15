extends Node
class_name Inventory
@onready var items: GridContainer = $VBoxContainer/Items
const ITEM_SLOT_SCENE: PackedScene = preload("res://UI/Inventory/ItemSlot.tscn")
# Called when the node enters the scene tree for the first time.
#func _ready():
	#for i in range(0, 20):
		#var slot: Node = ItemSlot.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
