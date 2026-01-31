extends Node


@export var player: CharacterBody3D
@export var animation: AnimationPlayer


func _physics_process(_delta: float) -> void:
	if not player.velocity.is_zero_approx():
		animation.play("Run")
	else:
		animation.pause()
