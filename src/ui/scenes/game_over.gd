extends Control

@export_file_path var main_menu_path: String
@export var timer: Timer
var can_leave = false

func _ready() -> void:
	EventBus.game_over.connect(_on_game_over)

func _input(event: InputEvent) -> void:
	if visible == false or not can_leave: 
		return

	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file(main_menu_path)
	elif event is InputEventKey or (event is InputEventMouseButton):
		get_tree().reload_current_scene()


func _on_game_over() -> void:
	visible = true
	timer.start()


func _on_timer_timeout() -> void:
	can_leave = true

