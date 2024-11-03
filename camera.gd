## The main camera found in levels.
extends Camera3D
class_name Camera


@export var movement_speed := 1.0
@export var rotation_speed := 5.0

@onready var root: Node3D = %CameraRoot
@onready var position_target: Node3D = %CameraRoot/PositionTarget
@onready var rotation_target: Node3D = %CameraRoot/RotationTarget


func _process(delta):
	var target_position := Vector3.ZERO

	for character: Character in get_tree().get_nodes_in_group("characters"):
		target_position += character.global_position
	
	target_position /= get_tree().get_node_count_in_group("characters")

	position_target.global_position = position_target.global_position.lerp(
		target_position, min(delta * movement_speed, 1.0))
	
	rotation_target.global_position = rotation_target.global_position.lerp(
		target_position, min(delta * rotation_speed, 1.0))
	
	root.global_position = position_target.global_position
	look_at_from_position(global_position, rotation_target.global_position)
	return
