extends Area3D

var is_active_for_player: bool = false
var start_time_stamp: float

func _ready() -> void:
	EventBus.shopping_list_fulfilled.connect(_on_shopping_list_fulfilled)
	start_time_stamp = Time.get_unix_time_from_system()


func _on_shopping_list_fulfilled() -> void:
	is_active_for_player = true
	print("you can now leave the store")


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and is_active_for_player:
		var elapsed_time = Time.get_unix_time_from_system() - start_time_stamp
		print(elapsed_time)
		EventBus.level_completed.emit(elapsed_time)
		print("level won")
	if body.is_in_group("npc"):
		body = body as NPC
		if body.behavior_tree.blackboard.get_value("is_checked_out") == true:
			body.queue_free()
