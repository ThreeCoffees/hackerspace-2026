extends MeshInstance3D

func _ready() -> void:
	EventBus.mask_off.connect(_mask_off)
	EventBus.mask_on.connect(_mask_on)


func _mask_off() ->void:
	visible = false

func _mask_on() ->void:
	visible = true
