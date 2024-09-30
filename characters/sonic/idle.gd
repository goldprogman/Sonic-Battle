extends BehaviourTreeLeaf


func activated():
	if references.animation_player.current_animation != 'idle':
		references.animation_player.play('idle')
	root.active_path.pop_back() # Evaluate parent selector next frame.
	return

