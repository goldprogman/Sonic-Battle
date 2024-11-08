## Responsible for handling input.
extends Node
class_name PlayerController


@export var character: Character = null


var keys_down := []
func _input(_event):
	if !is_instance_valid(character): return

	#if event is InputEventKey:
		#if event.keycode == KEY_SPACE:
			#if event.pressed: character.jump()
#
		#if !(event.keycode in [KEY_W, KEY_A, KEY_S, KEY_D, KEY_G]): return
		#
		#if event.pressed:
			#if !(event.keycode in keys_down): keys_down.append(event.keycode)
		#else:
			#if event.keycode in keys_down: keys_down.erase(event.keycode)
		#
		#var new_target_velocity := Vector2.ZERO
		#if KEY_W in keys_down: new_target_velocity.y += 1
		#if KEY_A in keys_down: new_target_velocity.x -= 1
		#if KEY_S in keys_down: new_target_velocity.y -= 1
		#if KEY_D in keys_down: new_target_velocity.x += 1
		#if KEY_G in keys_down: new_target_velocity *= 0.3
		#character.target_velocity = new_target_velocity
	if Input.is_action_just_pressed("jump"): character.jump()
	var new_target_velocity = Input.get_vector("move_left", "move_right", "move_down", "move_up")
	if Input.is_action_pressed("move_modifier"): new_target_velocity *= 0.3
	character.target_velocity=new_target_velocity
	return
