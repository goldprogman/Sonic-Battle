## A base class for all behaviour tree nodes.
extends Node
class_name BehaviourTreeNode


var root: BehaviourTree = null
var blackboard := {}


## Called in order once the behaviour tree is ready.
func start(blackboard: Dictionary):
	self.blackboard = blackboard
	root = blackboard.root
	return


func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		# Make sure to clean up active path to ensure no invalid references.
		var needs_evaluation := false

		while self in root.active_path:
			root.active_path.pop_back()
			needs_evaluation = true
		
		if needs_evaluation: root.evaluate()
	return
