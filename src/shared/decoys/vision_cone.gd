extends Node3D

@export var view_distance: float = 15.0
@export var view_max_angle: float = PI/4

signal item_visible(position: Vector3)

func _physics_process(delta: float) -> void:
	for item in get_tree().get_nodes_in_group("decoy_items"):
		check_is_item_visible(item)

func check_is_item_visible(item: Node3D) -> void:
	var ray_angle = abs(basis.x.angle_to(item.position.direction_to(position)))
	if ray_angle > view_max_angle:
		return

	if item.position.distance_to(position) > view_max_angle:
		return

	var ray = RayCast3D.new()
	add_child(ray)
	ray.target_position = item.position

	if not ray.is_colliding():
		print("item visible")
		item_visible.emit(item.position)
		
		
