extends CharacterBody3D

@export var speed: float = 500.0
@export var steering: float = 10.0
@export var camera: Camera3D
@export var mesh: Node3D

var mouse_position: Vector2 = Vector2.ZERO

var move_direction: Vector3 = Vector3.ZERO
var look_direction: float = 0.0


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_position = event.position


func _physics_process(delta: float) -> void:
	move_direction.x = Input.get_axis("move_left", "move_right")
	move_direction.z = Input.get_axis("move_up", "move_down")
	move_direction = move_direction.normalized()

	velocity = move_direction * speed * delta

	look_direction = 2 * PI - (Vector2(get_window().size) / 2).angle_to_point(mouse_position)
	mesh.rotation.y = look_direction

	move_and_slide()
