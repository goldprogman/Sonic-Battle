extends State

func enter():
	pass
func think(delta: float):
	char.run_velocity = Input.get_vector("move_left", "move_right", "move_down", "move_up")
	char.doVelocity(delta)
	if(Input.is_action_just_pressed("jump")):
		machine.goto("Jump")
		return
	if(char.velocity.length() <= 0.1):
		char.velocity = Vector3.ZERO
		machine.goto("Idle")
		return
func exit():
	pass
