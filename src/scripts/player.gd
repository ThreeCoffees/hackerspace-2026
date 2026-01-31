extends CharacterBody3D

@onready var camera_mount = $camera_mount
@onready var animation_player = $visuals/mixamo_base/AnimationPlayer
@onready var visuals = $visuals

var SPEED = 2.8
const JUMP_VELOCITY = 4.5

var walking_speed = 3.0
var running_speed = 5.0

var running = false

@export var sens_horizontal = 0.15
@export var sens_vertical = 0.15

@export var max_look_up := 60.0
@export var max_look_down := -40.0

@export var is_mask_on: bool = true

var camera_pitch := 0.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		# 🔹 obrót GRACZA (yaw)
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))

		# 🔹 obrót kamery góra/dół (pitch)
		camera_pitch -= event.relative.y * sens_vertical
		camera_pitch = clamp(camera_pitch, max_look_down, max_look_up)
		camera_mount.rotation_degrees.x = camera_pitch
		
	if event.is_action_pressed("toggle_mask"):
		is_mask_on = !is_mask_on

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("run"):
		SPEED = running_speed
		running = true
	else:
		SPEED = walking_speed
		running = false

	var gravity := 9.8
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(-input_dir.x, 0, -input_dir.y)).normalized()

	if direction:
		if running:
			if animation_player.current_animation != "running":
				animation_player.play("running")
		else:
			if animation_player.current_animation != "walking":
				animation_player.play("walking")

		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if animation_player.current_animation != "idle":
			animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
