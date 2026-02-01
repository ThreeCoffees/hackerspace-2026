extends CharacterBody3D

@export var is_mask_on: bool = true
@export var infection_timer: Timer
@export var infection_timer_unmasked: Timer
@export var raycast: RayCast3D
var is_being_infected: bool = false

var player: CharacterBody3D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_mask"):
		is_mask_on = not is_mask_on
		if is_mask_on:
			EventBus.mask_on.emit()
		else:
			EventBus.mask_off.emit()
		print("is mask on:", is_mask_on)

func _physics_process(delta: float) -> void:
	if is_being_infected == true:
		if is_mask_on and infection_timer.is_stopped():
			infection_timer.start()
		elif infection_timer_unmasked.is_stopped():
			infection_timer_unmasked.start()
			print("unmasked start")
	if is_being_infected == false:
		infection_timer.stop()
		infection_timer_unmasked.stop()

	is_being_infected = false
		

func _on_infection_timer_timeout() -> void:
	EventBus.game_over.emit()
	print("game over")
