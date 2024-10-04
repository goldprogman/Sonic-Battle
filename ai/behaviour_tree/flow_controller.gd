## Manages the flow of execution in a behaviour tree.
extends BehaviourTreeNode
class_name BehaviourTreeFlowController


func start(blackboard: Dictionary):
	super.start(blackboard)
	for child in get_children():
		if is_instance_of(child, BehaviourTreeNode):
			child.start(blackboard)
	return


func evaluate() -> BehaviourTreeNode:
	return null
