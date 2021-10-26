class_name GDActionNodeRepeat extends GDActionNodeInstant

var number_repeat := 1
var action_repeat
var _count_repeat_action := 0


func get_class() -> String:
	return "GDActionNodeRepeat"


func _init(action, key, node).(action, key, node):
	pass


func start_repeat(action_repeat, number_repeat: int, delay: float , speed: float):
	self.action_repeat = action_repeat
	self.number_repeat = number_repeat
	self.delay = delay
	self.speed = speed

	_reset_value()
	_run()


func _start_action():
	_run_repeat(1)


func _on_action_object_completed(action_node):
	action_node.disconnect("finished", self, "_on_action_object_completed")

	if _count_repeat_action >= number_repeat:
		finished()
		return
	
	_run_repeat(_count_repeat_action + 1)


func _run_repeat(count: int) -> void:
	_count_repeat_action = count
	
	if not is_instance_valid(node):
		finished()
		return
	
	var action_node = action_repeat._start_from_action(node, key, speed)
	
	if not action_node.is_connected("finished", self, "_on_action_object_completed"):
		action_node.connect("finished", self, "_on_action_object_completed")

