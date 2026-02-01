class_name NPC
extends CharacterBody3D

@export var nav_agent: NavigationAgent3D
@export var behavior_tree: BeehaveTree
@export var speed: float = 3.0
@export var item_speed_modifier: float = 2.0
@export var tolerance_distance: float = 30.0
@export var tolerance_distance_masked_modifier: float = 0.5 
@export var run_away_distance: float = 10.0
@export var infection_radius: float = 10.0

var nav_region: NavigationRegion3D


func _ready() -> void:
	nav_region = get_tree().get_first_node_in_group("nav_region")
	nav_agent.velocity_computed.connect(_on_velocity_computed)

	behavior_tree.blackboard.set_value("player", get_tree().get_first_node_in_group("player"))


func _physics_process(_delta: float) -> void:
	var next_path_node = nav_agent.get_next_path_position()
	var dir = global_position.direction_to(next_path_node)
	var new_vel = dir * speed

	nav_agent.velocity = new_vel
	dir.y = 0
	rotation.y = 3 * PI / 2 + atan2(velocity.x, velocity.z)

	var player = get_tree().get_first_node_in_group("player") as CharacterBody3D
	if player:
		var distance = global_position.distance_to(player.global_position)
		if distance < infection_radius:
			player.is_being_infected = true

func _on_velocity_computed(safe_vel: Vector3) -> void:
	velocity = velocity.move_toward(safe_vel, 100)
	move_and_slide()


func set_new_wander_point() -> void:
	var random_point = NavigationServer3D.region_get_random_point(nav_region.get_rid(), 1, false)
	random_point = NavigationServer3D.region_get_closest_point(nav_region.get_rid(), random_point)
	nav_agent.target_position = random_point


func set_run_away_point(threat_pos: Vector3) -> void:
	var point = threat_pos.direction_to(global_position) * run_away_distance
	var run_away_point = NavigationServer3D.region_get_closest_point(nav_region.get_rid(), point)
	nav_agent.target_position = run_away_point

func set_exit_target() -> void:
	var point = get_tree().get_first_node_in_group("level_finish").global_position
	var exit_position = NavigationServer3D.region_get_closest_point(nav_region.get_rid(), point)
	nav_agent.target_position = exit_position


func set_checkout_target() -> void:
	var checkouts  = get_tree().get_nodes_in_group("checkouts")
	var dest = Vector3(10000,0,0)
	for c in checkouts:
		c = c as Checkout
		if c.checkout_area.global_position.distance_to(global_position) <= dest.distance_to(global_position):
			dest = c.global_position

	nav_agent.target_position = dest


func _on_vision_cone_item_visible(position: Vector3) -> void:
	var closest_item_position = NavigationServer3D.region_get_closest_point(nav_region.get_rid(), position)
	if behavior_tree.blackboard.has_value("item_position"):
		if global_position.distance_to(closest_item_position) > global_position.distance_to(behavior_tree.blackboard.get_value("item_position")):
			closest_item_position = behavior_tree.blackboard.get_value("item_position")
	behavior_tree.blackboard.set_value("item_position", closest_item_position)
