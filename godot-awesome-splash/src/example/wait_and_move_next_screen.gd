extends Node

#export(bool) var is_skip_appear_transition = false
#export(bool) var is_skip_disappear_transition = false


#For this example I will wait 2s with this screen

# This func will auto call from Splash
func _custom_splash_did_appear():
	var time_in_seconds = 2
	yield(get_tree().create_timer(time_in_seconds), "timeout")
	
	var container = sp.get_current_splash_container()
	container.transition_next_screen()

func _custom_splash_did_disappear():
	pass
