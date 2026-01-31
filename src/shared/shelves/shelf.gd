class_name Shelf
extends MeshInstance3D

enum Item {
	TOILET_PAPER,
	WATER,
	PASTA,
	NONE,
}

@export var interactable_area: Area3D
@export var item: Item
@export var count: int

var is_picked: bool = false

func _input(event: InputEvent) -> void:
	if is_picked and event.is_action_pressed("interact_primary"):
		EventBus.interacted_with_shelf.emit(self)


func _on_static_body_3d_mouse_exited() -> void:
	is_picked = false

func _on_static_body_3d_mouse_entered() -> void:
	is_picked = true

