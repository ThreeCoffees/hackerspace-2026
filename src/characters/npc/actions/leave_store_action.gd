@tool
extends ActionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	actor = actor as NPC

	actor.set_exit_target()

	return SUCCESS
