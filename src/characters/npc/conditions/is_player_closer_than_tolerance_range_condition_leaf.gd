@tool
extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor = actor as NPC
	var distance_form_player = actor.global_position.distance_to(
		blackboard.get_value("player").global_position
	)

	var tolerance_distance = actor.tolerance_distance
	if blackboard.get_value("player").is_mask_on:
		tolerance_distance *= actor.tolerance_distance_masked_modifier

	if tolerance_distance >= distance_form_player:
		return SUCCESS
	return FAILURE
