extends Node

@export var item_spawn: Node3D
@export var item_scenes: Dictionary[Shelf.Item, PackedScene]
@export var throw_strength: float = 10.0


func _ready() -> void:
	EventBus.item_thrown.connect(_on_item_thrown)


func _on_item_thrown(item: Shelf.Item) -> void:
	print("item thrown ", item)
	if item == Shelf.Item.NONE:
		return
	var item_scene = item_scenes[item]
	var i = item_scene.instantiate()
	print(i as RigidBody3D)
	var throw_direction = Vector3.RIGHT.rotated(Vector3.UP, item_spawn.global_rotation.y)
	i.position = item_spawn.global_position
	i.apply_central_impulse(throw_direction * throw_strength)
	get_tree().root.add_child(i)
