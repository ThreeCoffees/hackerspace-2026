extends CharacterBody3D

@export var nav_agent: NavigationAgent3D
@export var speed: float = 3.0
@export var wait_timer: Timer

var nav_region: NavigationRegion3D

func _ready() -> void:
	nav_region = get_tree().get_first_node_in_group("nav_region")
	nav_agent.navigation_finished.connect(set_new_wander_point)
	nav_agent.velocity_computed.connect(_on_velocity_computed)
	wait_timer.start()


func _physics_process(delta: float) -> void:
	var next_path_node = nav_agent.get_next_path_position()
	var dir = global_position.direction_to(next_path_node)
	var new_vel = dir * speed

	nav_agent.velocity = new_vel
	dir.y = 0
	rotation.y = 3*PI/2 + atan2(velocity.x, velocity.z)


func _on_velocity_computed(safe_vel: Vector3) -> void:
	velocity = velocity.move_toward(safe_vel, 100)
	move_and_slide()


func set_new_wander_point() -> void:
	var random_point = NavigationServer3D.region_get_random_point(nav_region.get_rid(), 1, false)
	random_point = NavigationServer3D.region_get_closest_point(nav_region.get_rid(), random_point)
	nav_agent.target_position = random_point


func _on_wait_timer_timeout() -> void:
	set_new_wander_point()
