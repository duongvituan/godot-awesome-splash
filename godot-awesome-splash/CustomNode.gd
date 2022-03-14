extends Node2D


func _input(event):
	if event.is_action_pressed("reset_demo"):
		var container = sp.get_current_splash_container()
		container.play_next_screen()
