# Copyright 2024 Alison Janvier
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Responsible for handling input.
extends Node
class_name PlayerController


@export var character: Character = null


#TODO: Rework this to work with controllers
var keys_down := []
func _input(event):
	if !is_instance_valid(character): return

	if event is InputEventKey:
		if event.keycode == KEY_SPACE:
			if event.pressed: character.jump()

		if !(event.keycode in [KEY_W, KEY_A, KEY_S, KEY_D]): return
		
		if event.pressed:
			if !(event.keycode in keys_down): keys_down.append(event.keycode)
		else:
			if event.keycode in keys_down: keys_down.erase(event.keycode)
		
		var new_target_velocity := Vector2.ZERO
		if KEY_W in keys_down: new_target_velocity.y += 1
		if KEY_A in keys_down: new_target_velocity.x -= 1
		if KEY_S in keys_down: new_target_velocity.y -= 1
		if KEY_D in keys_down: new_target_velocity.x += 1
		character.target_velocity = new_target_velocity
	return

