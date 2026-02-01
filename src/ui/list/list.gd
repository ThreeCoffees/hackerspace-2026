extends Control

@export var anim_player: AnimationPlayer
@export var list_image: TextureRect
@export var text_label: RichTextLabel
@export var inventory_manager: Node

var item_string: Dictionary[Shelf.Item, String] = {
	Shelf.Item.TOILET_PAPER : "TOILET_PAPER",
	Shelf.Item.WATER : "WATER",
	Shelf.Item.CAN_OF_TUNA : "CAN_OF_TUNA",
	Shelf.Item.NONE : "NONE"
}

var shopping_list: ShoppingList
var is_up: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shopping_list = inventory_manager.shopping_list
	is_up = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_list"):
		write_list()
		if is_up:
			anim_player.play("slide down")
		else:
			anim_player.play("slide up")
		is_up = !is_up

func write_list():
	var list = shopping_list.list
	var inventory = inventory_manager.inventory
	text_label.clear()
	for key in list.keys():
		var collected = 0
		if inventory.has(key):
			collected = inventory[key]
		var needed = clamp(list[key]-collected, 0, 100)
		var text = str(item_string[key], ": ", needed, "\n")
		text_label.append_text(text)
	
