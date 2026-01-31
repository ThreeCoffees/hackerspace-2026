extends CharacterBody3D

@export var speed := 6.0
@export var gravity := 20.0

@onready var camera: Camera3D = $SpringArm3D/Camera3D

func _physics_process(delta):
	# Grawitacja
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

	# Input WASD
	var input_dir := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
	)

	# Kierunek względem kamery
	var forward: Vector3 = -camera.global_transform.basis.z
	var right: Vector3 = camera.global_transform.basis.x
	var direction: Vector3 = (right * input_dir.x + forward * input_dir.y).normalized()

	# Prędkość pozioma
	var horizontal_velocity: Vector3 = Vector3(
		direction.x * speed,
		velocity.y,
		direction.z * speed
	)

	velocity = horizontal_velocity
	move_and_slide()

	# DEBUG: wypisanie pozycji i kierunku
	print("Player position:", global_transform.origin, " | Direction:", direction)
