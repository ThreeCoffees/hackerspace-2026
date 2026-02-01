extends Node3D

enum NpcType{
	MASKED,
	UNMASKED,
}

@export var spawn_weights: Dictionary[NpcType, int]
@export var spawn_timer: Timer
@export var masked_npc: PackedScene
@export var unmasked_npc: PackedScene

var weighted_array

func _ready() -> void:
	weighted_array = populate_weighted_array()
	print(weighted_array)
	spawn_timer.timeout.connect(spawn_customer)

func spawn_customer() -> void:
	var customer = weighted_array.pick_random()

	var instance
	match customer:
		NpcType.MASKED: 
			instance = masked_npc.instantiate()
	add_child(instance)
	instance.global_position = global_position

func populate_weighted_array() -> Array:
	var arr = []
	for key in spawn_weights.keys():
		for i in spawn_weights[key]:
			arr.push_back(key)
	return arr
