extends Node


var debug_options := {
	'esc_quit': true
}


func _input(event):
	if !debug_options.esc_quit: return
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.pressed: get_tree().quit()
	return

