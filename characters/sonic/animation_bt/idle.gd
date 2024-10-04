extends BehaviourTreeLeaf


func activated():
	if blackboard.animation_player.current_animation != 'idle':
		blackboard.animation_player.play('idle')
	root.active_path.pop_back() # Evaluate parent selector next frame.
	return


func tick(delta: float):
	if blackboard.character.velocity.length() > 0.01: root.reevaluate()
	return
