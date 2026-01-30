extends Node

var inventory: Dictionary[Shelf.Item, int] = {}

func _ready() -> void:
	ShoppingManager.interacted_with_shelf.connect(_on_interacted_with_shelf)

func _on_interacted_with_shelf(shelf: Shelf) -> void:
	inventory[shelf.item] = inventory.get(shelf.item, 0) + 1
	print(inventory)
