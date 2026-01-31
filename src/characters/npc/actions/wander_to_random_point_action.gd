@tool
extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor = actor as NPC

	if actor.nav_agent.is_navigation_finished():
		return SUCCESS
	return RUNNING
