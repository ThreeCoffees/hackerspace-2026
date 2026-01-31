extends Node3D

@export var checkout_area: Area3D
@export var checkout_timer: Timer


func _on_timer_timeout() -> void:
	EventBus.checked_out.emit()
	print("player checked out")


func _on_area_3d_body_exited(body: Node3D) -> void:
	print("player checkout interrupt")
	if body.is_in_group("player"):
		checkout_timer.stop()


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("player checkout start")
	if body.is_in_group("player"):
		checkout_timer.start()
