## A base class for all characters.
extends CharacterBody3D
class_name Character


signal jump_start
signal left_ground
signal landed


@export var max_speed := 10.0
@export var acceleration := 3.0
@export var deceleration := 3.0
@export var turning_boost := 2.0
@export var jump_strength := 15.0
@export var air_control := 1.0
@export var gravity := Vector3.DOWN * 9.81 * 4.0


@onready var floor_scan: RayCast3D = %FloorScan


var grounded := true:
	set(value):
		if value == grounded: return
		grounded = value
		if grounded: emit_signal('landed')
		else: emit_signal('left_ground')
		return
var target_velocity := Vector2.ZERO:
	set(val): target_velocity = val.limit_length(1.0)


func jump():
	if !grounded: return
	velocity.y = jump_strength
	floor_scan.enabled = false
	Game.delay(func(): floor_scan.enabled = true)
	grounded = false
	emit_signal('jump_start')
	return


func _physics_process(delta: float):
	if floor_scan.enabled: grounded = floor_scan.is_colliding()

	var corrected_target_velocity := Vector3(
		target_velocity.x,
		0.0,
		-target_velocity.y
	)
	corrected_target_velocity *= max_speed

	var weight := delta
	
	if corrected_target_velocity.length() <= 0.01: weight *= deceleration
	else:
		weight *= acceleration
		weight *= lerp(turning_boost, 1.0,
			(velocity.normalized().dot(
				corrected_target_velocity.normalized()
			) + 1) / 2
		)
	
	if !grounded: weight *= air_control

	if !grounded: velocity += gravity * delta
	
	corrected_target_velocity.y = velocity.y
	velocity = velocity.lerp(corrected_target_velocity, min(weight, 1.0))
	if velocity.length() <= 0.1: velocity = Vector3.ZERO

	move_and_slide()

