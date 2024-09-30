# Copyright 2024 Alison Janvier
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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
