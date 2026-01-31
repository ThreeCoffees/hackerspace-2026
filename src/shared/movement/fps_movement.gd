extends Node3D

@export var player: CharacterBody3D

@export var speed: float = 20.0
@export var camera: Camera3D
@export var camera_mount: Node3D

@export var sens_horizontal = 0.15
@export var sens_vertical = 0.15

@export var max_look_up: float = 60.0 
@export var max_look_down: float = -60.0

var mouse_position: Vector2 = Vector2.ZERO

var move_direction: Vector3 = Vector3.ZERO
var look_pitch: float = 0.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera.transform = camera_mount.transform
	camera.reparent.call_deferred(camera_mount)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		player.rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))

		look_pitch -= event.relative.y * sens_vertical
		look_pitch = clamp(look_pitch, max_look_down, max_look_up)
		camera_mount.rotation_degrees.x = look_pitch


func _physics_process(_delta: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	move_direction = (player.basis * Vector3(-input_dir.x, 0, -input_dir.y)).normalized().rotated(Vector3.UP, PI/2)

	player.velocity = move_direction * speed

	player.move_and_slide()
