class_name SkillMachine
extends Node

var char:Character:
	set(val):
		char = val
		for s in skills:
			if(s != null):
				s.char = val
var current_skill:Skill
var skills = []
enum Special {SHOT, POWER, TRAP}
var ground_special
var aerial_special
var defend_special

func _ready() -> void:
	skills.append(get_node("Idle"))
	skills.append(get_node("Run"))
	skills.append(get_node("Dash"))
	skills.append(get_node("Jump"))
	skills.append(get_node("ActionAir"))
	skills.append(get_node("Guard"))
	skills.append(get_node("Heal"))
	skills.append(get_node("Attack1"))
	skills.append(get_node("Attack2"))
	skills.append(get_node("Attack3"))
	skills.append(get_node("AttackHeavy"))
	skills.append(get_node("AttackUpper"))
	skills.append(get_node("AttackDash"))
	skills.append(get_node("AttackAir"))
	skills.append(get_node("AttackPursuit"))
	skills.append(get_node("ShotGround"))
	skills.append(get_node("ShotAir"))
	skills.append(get_node("PowerGround"))
	skills.append(get_node("PowerAir"))
	skills.append(get_node("TrapGround"))
	skills.append(get_node("TrapAir"))
	for s in skills:
		if(s != null):
			s.machine = self
	current_skill = skills[0]

func think(delta):
	current_skill.think(delta)

func goto(new_skill_id):
	current_skill.exit()
	current_skill = skills[new_skill_id]
	current_skill.enter()
