class_name GDActionNodeSequence extends GDActionNodeInstant

var index_action: int = 0
var list_action: Array = []


func get_class() -> String:
	return "GDActionNodeSequence"


func _init(action, key, node).(action, key, node):
	pass


func start_sequence(list_action: Array, delay: float, speed: float):
	self.list_action = list_action
	self.delay = delay
	self.speed = speed
	_reset_value()
	_run()


func _start_action():
	_run_sequence(0)


func _on_action_object_completed(action_node):
	action_node.disconnect("finished", self, "_on_action_object_completed")
	
	if index_action >= self.list_action.size() - 1:
		finished()
		return
	
	_run_sequence(index_action + 1)


func _run_sequence(index: int) -> void:
	if index >= list_action.size() or not is_instance_valid(node):
		finished()
		return
	
	index_action = index
	
	var current_action_object = list_action[index]._start_from_action(node, key, speed)
	
	if not current_action_object.is_connected("finished", self, "_on_action_object_completed"):
		current_action_object.connect("finished", self, "_on_action_object_completed")

