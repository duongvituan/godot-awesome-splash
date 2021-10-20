class_name GDActionNodeInstant extends GDActionNode


func _init(action, key, node).(action, key, node):
	pass


func get_class() -> String:
	return "GDActionNodeInstant"


func _process(delta):
	if not is_instance_valid(node):
		finished()
		return

	current_time += delta * speed
	if current_time <= delay:
		return
		
	set_process(false)
	_start_action()

# Virtual function
func _start_action():
	pass
	
