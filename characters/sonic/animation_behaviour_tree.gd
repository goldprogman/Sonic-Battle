extends BehaviourTree


func _ready():
	references.animation_player = get_parent()
	super._ready()
	return
