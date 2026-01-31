class_name ShoppingList
extends Node

@export var list_generation_weights: Dictionary[Shelf.Item, int]
@export var list_generation_count: int

var list: Dictionary[Shelf.Item, int] = {}


func _ready() -> void:
	generate_list()


func generate_list() -> void:
	var weighted_array = populate_weighted_array()
	for i in list_generation_count:
		var item = weighted_array.pick_random()
		list[item] = list.get(item, 0) + 1

	print(list)


func populate_weighted_array() -> Array:
	var arr = []
	for key in list_generation_weights.keys():
		for i in list_generation_weights[key]:
			arr.push_back(key)
	return arr


func is_fulfilled(inventory: Dictionary[Shelf.Item, int]) -> bool:
	for k in list.keys():
		if list[k] > inventory.get(k, 0):
			return false

	return true
