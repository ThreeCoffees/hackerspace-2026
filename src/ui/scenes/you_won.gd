extends Control

@export_file_path var main_menu_path: String
@export var timer: Timer
var can_leave = false

func _ready() -> void:
	EventBus.level_completed.connect(_on_level_completed)

func _input(event: InputEvent) -> void:
	if visible == false or not can_leave: 
		return

	if event is InputEventKey or (event is InputEventMouseButton):
		get_tree().change_scene_to_file(main_menu_path)


func _on_level_completed() -> void:
	visible = true
	timer.start()


func _on_timer_timeout() -> void:
	can_leave = true
