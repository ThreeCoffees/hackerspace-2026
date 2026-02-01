extends Control

@export_file_path var main_menu_path: String
@export var timer: Timer
@export var time_label: Label
@export var audio: AudioStreamPlayer
var can_leave = false

func _ready() -> void:
	EventBus.level_completed.connect(_on_level_completed)

func _input(event: InputEvent) -> void:
	can_leave = true
	if visible == false or not can_leave: 
		return

	if event is InputEventKey or (event is InputEventMouseButton):
		get_tree().change_scene_to_file(main_menu_path)


func _on_level_completed(time: float) -> void:
	visible = true
	time_label.text = "Time: %s" %[round(time *100)/100]
	audio.play()
	timer.start()
	Engine.time_scale = 0.0


func _on_timer_timeout(time: float) -> void:
	can_leave = true
