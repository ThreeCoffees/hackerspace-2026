extends Area3D


func _ready() -> void:
	EventBus.shopping_list_fulfilled.connect(_on_shopping_list_fulfilled)


func _on_shopping_list_fulfilled() -> void:
	self.monitoring = true
	self.monitorable = true
	print("you can now leave the store")


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		EventBus.level_completed.emit()
		print("level won")
