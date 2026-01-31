extends Node

@export var inventory_manager: InventoryManager


func _input(event: InputEvent) -> void:
	if event.is_action_released("throw_item"):
		throw_item()
		EventBus.item_thrown.emit()


func throw_item():
