extends BehaviourTreeLeaf


func activated():
	blackboard.animation_player.play('start_running')
	root.active_path.pop_back()
	return
