extends Node
class_name Inventory

@onready var items_container: GridContainer = $VBoxContainer/MarginContainer/Items
var item_slot_list: Array[ItemSlot] = []
const ITEM_SLOT_SCENE: PackedScene = preload("res://UI/Inventory/ItemSlot.tscn")


 #Called when the node enters the scene tree for the first time.
func _ready():
	GameState.inventory_updated.connect(_on_inventory_updated)
	for i in range(0, 20):
		var slot: Node = ITEM_SLOT_SCENE.instantiate()
		items_container.add_child(slot)
		item_slot_list.append(slot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_inventory_updated():
	for i in range(0, GameState.inventory.size()):
		var item: ItemIcon = GameState.inventory[i]
		if item.get_parent():
			item.get_parent().remove_child(item)
		item_slot_list[i].add_child(GameState.inventory[i])
