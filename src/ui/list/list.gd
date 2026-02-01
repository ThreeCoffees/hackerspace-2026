extends Control

@export var anim_player: AnimationPlayer
@export var list_image: TextureRect
@export var text_label: RichTextLabel
@export var inventory: Node

var shopping_list: ShoppingList
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shopping_list = inventory.shopping_list
	write_list()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_mask"):
		write_list()

func write_list():
	var list = shopping_list.list
	for key in list.keys():
		var text = str(list[key], ": ", key, "\n")
		text_label.append_text(text)
	
