extends Node

@export var player: CharacterBody3D

var inventory: Dictionary[Shelf.Item, int] = {}

func _ready() -> void:
	ShoppingManager.interacted_with_shelf.connect(_on_interacted_with_shelf)

func _on_interacted_with_shelf(shelf: Shelf) -> void:
	if shelf.count <= 0:
		return
	if not shelf.interactable_area.overlaps_body(player):
		return
	inventory[shelf.item] = inventory.get(shelf.item, 0) + 1
	shelf.count -= 1
	print(inventory)
	print(shelf.count)
