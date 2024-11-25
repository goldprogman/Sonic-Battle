class_name Skill
extends Node

var char
var machine
var age
@export var name_ingame:String
enum SkillType {
	IDLE,
	RUN,
	DASH,
	JUMP,
	ACTIONAIR,
	GUARD,
	HEAL,
	ATTACK1,
	ATTACK2,
	ATTACK3,
	ATTACKHEAVY,
	ATTACKUPPER,
	ATTACKDASH,
	ATTACKAIR,
	ATTACKPURSUIT,
	SHOTGROUND,
	SHOTAIR,
	POWERGROUND,
	POWERAIR,
	TRAPGROUND,
	TRAPAIR
}

func _ready() -> void:
	pass

func enter():
	pass
func think(delta: float):#, inputs):
	pass
func exit():
	pass
