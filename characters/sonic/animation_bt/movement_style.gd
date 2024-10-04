extends BehaviourTreeFlowController


func evaluate():
	if blackboard.character.target_velocity.length() <= 0.01: return $Idle
	else: return $StartRunning

