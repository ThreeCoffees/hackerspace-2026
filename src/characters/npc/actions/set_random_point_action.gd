@tool
extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor = actor as NPC

	actor.set_new_wander_point()

	return SUCCESS
