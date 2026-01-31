@tool
extends ActionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	actor = actor as NPC

	actor.set_run_away_point(blackboard.get_value("item_position"))

	if not actor.nav_agent.is_navigation_finished():
		return RUNNING
	return SUCCESS
	
