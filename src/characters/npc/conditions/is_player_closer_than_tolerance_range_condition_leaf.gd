@tool
extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	var distance_form_player = actor.global_position.distance_to(
		blackboard.get_value("player").global_position
	)

	if actor.tolerance_distance >= distance_form_player:
		return SUCCESS
	return FAILURE
