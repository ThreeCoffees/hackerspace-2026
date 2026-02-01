extends Node3D

@export var view_distance: float = 15.0
@export var view_max_angle: float = PI/3

signal item_visible(position: Vector3)

func _physics_process(delta: float) -> void:
	for item in get_tree().get_nodes_in_group("decoy_items"):
		check_is_item_visible(item)

func check_is_item_visible(item: Node3D) -> void:
	var ray_vector = item.global_position - global_position
	var ray_angle = ray_vector.signed_angle_to(Vector3.RIGHT, Vector3.DOWN)
	var ray_angle_diff = abs(global_rotation.y - ray_angle)
	if ray_angle_diff > view_max_angle:
		return

	var ray_distance = item.position.distance_to(position)
	if ray_distance > view_distance:
		return

	var ray = RayCast3D.new()
	add_child(ray)
	ray.global_position = global_position
	ray.target_position = ray_vector
	ray.set_collision_mask_value(4, true)

	if ray.is_colliding():
		print("item blocked by walls")
	else:
		item_visible.emit(item.global_position)
		
		
