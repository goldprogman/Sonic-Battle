## Manages the flow of execution in a behaviour tree.
extends BehaviourTreeNode
class_name BehaviourTreeFlowController


func start(references: Dictionary):
	super.start(references)
	for child in get_children():
		if is_instance_of(child, BehaviourTreeNode):
			child.start(references)
	return


func evaluate() -> BehaviourTreeNode:
	return null
