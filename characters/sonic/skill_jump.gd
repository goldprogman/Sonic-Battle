extends Skill

func enter():
	char.jump()
func think(delta: float):
	char.run_velocity = Input.get_vector("move_left", "move_right", "move_down", "move_up")
	char.doVelocity(delta)
	if(char.velocity.length() <= 0.1):
		char.velocity = Vector3.ZERO
	if(char.velocity.y <= 0 or char.grounded):
		machine.goto(SkillType.RUN)
		return
func exit():
	pass
