# Copyright 2024 Alison Janvier
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## A base class for all characters.
extends CharacterBody3D
class_name Character


@export var max_speed := 10.0
@export var acceleration := 3.0
@export var deceleration := 3.0
@export var turning_boost := 2.0
@export var jump_strength := 15.0
@export var air_control := 1.0
@export var gravity := Vector3.DOWN * 9.81 * 4.0


var target_velocity := Vector2.ZERO:
	set(val): target_velocity = val.limit_length(1.0)


func jump():
	if !is_on_floor(): return
	velocity.y = jump_strength
	return


func _physics_process(delta: float):
	var corrected_target_velocity := Vector3(
		target_velocity.x,
		0.0,
		-target_velocity.y
	)
	corrected_target_velocity *= max_speed

	var weight := delta
	
	if target_velocity.length() <= 0.01: weight *= deceleration
	else:
		weight *= acceleration
		weight *= lerp(turning_boost, 1.0,
			(velocity.normalized().dot(
				corrected_target_velocity.normalized()
			) + 1) / 2
		)
	
	if !is_on_floor(): weight *= air_control

	if !is_on_floor(): velocity += gravity * delta
	
	corrected_target_velocity.y = velocity.y
	velocity = velocity.lerp(corrected_target_velocity, min(weight, 1.0))

	move_and_slide()

