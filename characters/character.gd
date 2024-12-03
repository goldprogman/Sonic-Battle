## A base class for all characters.
extends CharacterBody3D
class_name Character


signal jump_start
signal left_ground
signal landed
signal is_attacking
signal blocking
signal unblocking
signal attack_count(count)


@export var max_speed := 8.0
@export var acceleration := 4.0
@export var deceleration := 5.0
@export var turning_boost := 3.0
@export var jump_strength := 17.0
@export var air_control := 0.4
@export var jump_gravity := Vector3.DOWN * 9.81 * 5.0
@export var fall_gravity := Vector3.DOWN * 9.81 * 3.0
var statemachine

var gravity := fall_gravity

var isAttack := false
var attackCount := 0
var atkCountDown:= 0

var isBlocking := false

var weight: float # Traction

#@onready var floor_scan: RayCast3D = %FloorScanRay

@onready var floor_scan: Area3D = %FloorScanArea
@onready var floor_scan_collision: CollisionShape3D = %FlrScnArCol

## Set the grounded variable, and emit related signals.
var grounded := true:
	set(value):
		if value == grounded: return
		grounded = value
		# If wasn't grounded, but now is, emit "landed".
		if grounded: 
			if velocity.y <= 0: emit_signal("landed")
		# Else, emit, "left_ground"
		else: emit_signal("left_ground")
		return
## Set the target velocity variable.
var run_velocity := Vector2.ZERO:
	set(val): run_velocity = val.limit_length(1.0)

## Character jump function.
func jump():
	if !grounded: return
	velocity.y = jump_strength
	#floor_scan.enabled = false
	floor_scan_collision.disabled = true

	# Disables the floor scan for 1 frame.
	Game.delay(func():
		#floor_scan.enabled = true
		floor_scan_collision.disabled = false)
	grounded = false
	emit_signal("jump_start")
	return

## Character attack function.
func attack():
	if grounded:
		emit_signal("is_attacking")
		isAttack = true
		if atkCountDown < 12:
			attackCount += 1
			atkCountDown = 24
	return


func block(isB: bool):
	if isB:
		if grounded:
			emit_signal("blocking")
			isBlocking = true
			atkCountDown = 0
			attackCount = 0
		else:
			isBlocking = false
	else:
		emit_signal("unblocking")
		isBlocking = false
	return


func _ready():
	statemachine = get_node("StateMachine")
	statemachine.char = self
	if is_on_floor():
		grounded = true
	else:
		grounded = false


## Non-physics related code.
func _process(delta):
	# Sets the drop shadow to the floor, or disables it if there is no nearby floor.
	if atkCountDown > 0:
		atkCountDown -= 1
	else:
		attackCount = 0
	if attackCount >= 4: attackCount = 0
	emit_signal("attack_count", attackCount)


## Physics related code.
func _physics_process(delta: float):
	weight = 1
	statemachine.think(delta)
	move_and_slide()

func doVelocity(delta: float):
	# Turns the target velocity (Vector2) into Vector3.
	var corrected_run_velocity := Vector3(
		run_velocity.x,
		0.0,
		-run_velocity.y
	)
	corrected_run_velocity *= max_speed

	# Sets the accelerations based on the if the character has a target velocity.
	if corrected_run_velocity.length() <= 0.01: weight *= deceleration
	else:
		weight *= acceleration
		weight *= lerp(turning_boost, 1.0,
			(velocity.normalized().dot(
				corrected_run_velocity.normalized()
			) + 1) / 2
		)

	# Changes the weight if in the air.
	if !grounded: weight *= air_control
	
	# Adds gravity, based on if the character is moving up or falling.
	if !grounded:
		if velocity.y <= 0: gravity = fall_gravity
		if velocity.y > 0: gravity = jump_gravity
		velocity += gravity * delta
	
	# The target velocity Y is set to the actual velocity Y, so it can plug into the velocity without problems.
	corrected_run_velocity.y = velocity.y
	velocity = velocity.lerp(corrected_run_velocity, min(delta*weight, 1.0))


## Checks whether the player is on the ground usng the area.
func _on_floor_scan_area_body_entered(body):
	grounded = true

func _on_floor_scan_area_body_exited(body):
	if !is_on_floor():
		grounded = false

func _get_camera_basis() -> float:
	return get_viewport().get_camera_3d().basis.get_euler().y
