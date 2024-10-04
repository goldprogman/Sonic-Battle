extends BehaviourTreeLeaf


func activated(): blackboard.animation_player.play('running')


func tick(delta: float):
	if blackboard.character.target_velocity.length() <= 0.01:
		for i in range(2): root.active_path.pop_back()
		root.evaluate()
	return

