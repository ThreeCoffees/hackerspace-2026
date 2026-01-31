extends Node

@export var player: CharacterBody3D
@export var item_scene: PackedScene
@export var throw_strength: float = 50.0
@export var throw_offset: float = 1.0
@export var throw_height: float = 1.0

var inventory: Dictionary[Shelf.Item, int] = {}
var active_item_idx: int = 0:
	set(new_value):
		if inventory.is_empty():
			active_item_idx = 0
		else:
			active_item_idx = new_value % inventory.size()
		print(get_active_item())

func get_active_item() -> Shelf.Item:
	if inventory.is_empty():
		return Shelf.Item.NONE
	return inventory.keys()[active_item_idx]

func _ready() -> void:
	EventBus.interacted_with_shelf.connect(_on_interacted_with_shelf)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("switch_active_item_next"):
		active_item_idx += 1
	if event.is_action_pressed("switch_active_item_prev"):
		active_item_idx -= 1
	if event.is_action_released("throw_item"):
		throw_item()

func _on_interacted_with_shelf(shelf: Shelf) -> void:
	if shelf.count <= 0:
		return
	if not shelf.interactable_area.overlaps_body(player):
		return
	
	inventory[shelf.item] = inventory.get(shelf.item, 0) + 1
	shelf.count -= 1

func throw_item() -> void:
	if not get_active_item() in inventory:
		return

	var thrown_item = get_active_item()
	inventory[thrown_item] -= 1
	if inventory[thrown_item] <= 0:
		inventory.erase(thrown_item)
		active_item_idx = 0

	print("item %s was thrown" % [thrown_item])

	var i = item_scene.instantiate() as RigidBody3D
	get_tree().root.add_child(i)
	var throw_direction = Vector3.RIGHT.rotated(Vector3.UP, player.look_direction)
	i.position = player.position + throw_direction * throw_offset
	i.position.y += throw_height
	i.apply_central_impulse(throw_direction * throw_strength)
	
