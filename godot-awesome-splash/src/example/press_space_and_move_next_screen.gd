extends Node2D

# Fox this example I will wait for user press space_key to move next screen
func _input(event):
	# User tap space_key
	if event.is_action_pressed("active"):
		var container = sp.get_current_splash_container()
		container.transition_next_screen()
