class_name NPC
extends CharacterBody3D

@export var nav_agent: NavigationAgent3D
@export var speed: float = 3.0
@export var tolerance_distance: float = 30.0
@export var tolerance_distance_masked_modifier: float = 0.5 
@export var run_away_distance: float = 10.0
@export var behavior_tree: BeehaveTree

var nav_region: NavigationRegion3D


func _ready() -> void:
	nav_region = get_tree().get_first_node_in_group("nav_region")
	nav_agent.velocity_computed.connect(_on_velocity_computed)

	behavior_tree.blackboard.set_value("player", get_tree().get_first_node_in_group("player"))


var proximity_timer := 0.0
const PROXIMITY_DURATION := 5.0
const PROXIMITY_RADIUS := 3.4

func _physics_process(_delta: float) -> void:
	var next_path_node = nav_agent.get_next_path_position()
	var dir = global_position.direction_to(next_path_node)
	var new_vel = dir * speed
	nav_agent.velocity = new_vel

	dir.y = 0
	rotation.y = 3 * PI / 2 + atan2(velocity.x, velocity.z)

	var player = get_tree().get_first_node_in_group("player")
	if player:
		var distance = global_position.distance_to(player.global_position)

		if distance < PROXIMITY_RADIUS:
			proximity_timer += _delta
			if proximity_timer >= PROXIMITY_DURATION:
				EventBus.game_over.emit()
		else:
			proximity_timer = 0.0


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
