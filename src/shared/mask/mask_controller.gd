extends Node

@export var is_mask_on: bool = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_mask"):
		is_mask_on = not is_mask_on
		print("is mask on:", is_mask_on)
