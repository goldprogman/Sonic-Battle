# Copyright 2024 Alison Janvier
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Cycles through each of it's children, one by one.
extends BehaviourTreeFlowController
class_name BehaviourTreeSequencer


# TODO:
# At the moment, changing the order/removing/adding children to this node
# at runtime will have unintended consequences.
# Currently this can somewhat be fixed by reevaluating the tree,
# but this is not ideal.


var current_id := -1


func start(blackboard: Dictionary):
	blackboard.root.connect('reevaluating', func(): current_id = -1)
	super.start(blackboard)
	return


func evaluate() -> BehaviourTreeNode:
	var branches: Array[BehaviourTreeNode] = []
	for child in get_children():
		if is_instance_of(child, BehaviourTreeNode): branches.append(child)
	
	if len(branches) == 0: current_id = -1; return null

	current_id = wrap(current_id + 1, 0, len(branches))
	return branches[current_id]

