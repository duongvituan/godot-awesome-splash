class_name GDActionNodeRun extends GDActionNodeInstant

var run_action
var on_target: Node
var is_waiting_finished: bool


func get_class() -> String:
	return "GDActionNodeRun"


func _init(action, key, node):
	super(action, key, node)


func start_run_action(run_action, on_target: Node, is_waiting_finished: bool, delay: float, speed: float):
	self.run_action = run_action
	self.on_target = on_target
	self.is_waiting_finished = is_waiting_finished
	self.delay = delay
	self.speed = speed
	_reset_value()
	_run()


func _start_action():
	_start_run_action(run_action, on_target, is_waiting_finished)


func _on_action_object_completed(action_node):
	action_node.finished_action_signal.disconnect(self._on_action_object_completed)
	finished()


func _start_run_action(run_action, on_target, is_waiting_finished) -> void:
	if not (is_instance_valid(node) and is_instance_valid(on_target)):
		finished()
	
	var action_node = run_action._start_from_action(on_target, key, speed)
	
	if not is_waiting_finished:
		finished()
	
	if not action_node.finished_action_signal.is_connected(self._on_action_object_completed):
		action_node.finished_action_signal.connect(self._on_action_object_completed)
		

