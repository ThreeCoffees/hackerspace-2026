@tool
extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor = actor as NPC

	actor.set_run_away_point(blackboard.get_value("player").global_position)

	return RUNNING
