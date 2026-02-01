extends Control

@export_file_path() var level_path: String

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_options_button_pressed() -> void:
	get_tree().quit()

func _on_start_button_pressed() -> void:
	print("switching levels")
	get_tree().change_scene_to_file(level_path)

