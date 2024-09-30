## The main camera found in levels.
extends Camera3D
class_name Camera


@export var speed := 5.0


func _init():
	return


func _process(delta):
	var target_position := Vector3.ZERO

	for character: Character in get_tree().get_nodes_in_group("characters"):
		target_position += character.global_position
	
	target_position /= get_tree().get_node_count_in_group("characters")

	%CameraRoot.global_position = %CameraRoot.global_position.lerp(
		target_position,
		min(delta * speed, 1.0)
	)
	return

