extends Node

func _ready() -> void:
	ShoppingManager.interacted_with_shelf.connect(_on_interacted_with_shelf)

func _on_interacted_with_shelf(shelf: Shelf) -> void:
	print("interacted with %s" % [shelf])
