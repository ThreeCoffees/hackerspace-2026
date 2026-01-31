extends Node

@export var shopping_list: ShoppingList


func _ready() -> void:
	shopping_list.generate_list()
	EventBus.checked_out.connect(_on_checked_out)


func _on_checked_out() -> void:
	pass
