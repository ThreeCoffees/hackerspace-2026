class_name Shelf
extends Node3D

enum Item {
	TOILET_PAPER,
	WATER,
	CAN_OF_TUNA,
	NONE,
}

@export var interactable_area: Area3D
@export var collision_shape: StaticBody3D
@export var item: Item
@export var count: int

var is_picked: bool = false
var player: CharacterBody3D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _input(event: InputEvent) -> void:
	is_picked = (player.raycast as RayCast3D).get_collider() == collision_shape
	if is_picked and event.is_action_pressed("interact_primary"):
		EventBus.interacted_with_shelf.emit(self)
