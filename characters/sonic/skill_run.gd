extends Skill

func enter():
	pass
func think(delta: float):
	char.run_velocity = Input.get_vector("move_left", "move_right", "move_down", "move_up")
	char.doVelocity(delta)
	if(Input.is_action_just_pressed("jump")):
		machine.goto(SkillType.JUMP)
		return
	if(char.velocity.length() <= 0.1):
		char.velocity = Vector3.ZERO
		machine.goto(SkillType.IDLE)
		return
func exit():
	pass
