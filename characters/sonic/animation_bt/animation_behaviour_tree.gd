extends BehaviourTree


func _ready():
	blackboard.character = owner
	blackboard.animation_player = get_parent()
	blackboard.facing_right = true
	super._ready()
	return

