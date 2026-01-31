@tool
extends ActionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	actor = actor as NPC

	actor.nav_agent.target_position = blackboard.get_value("item_position")
	blackboard.erase_value("item_position")

	return RUNNING
	
