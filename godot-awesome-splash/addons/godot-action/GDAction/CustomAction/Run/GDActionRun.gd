class_name GDActionRun extends GDActionInstant

var run_action: GDAction
var on_target: Node
var is_waiting_finished: bool


func _init(action: GDAction, on_target: Node, is_waiting_finished: bool, gd_utils: Node).(gd_utils):
	self.run_action = action
	self.on_target = on_target
	self.is_waiting_finished = is_waiting_finished


func _create_action_node(key: String, node):
	return GDActionNodeRun.new(self, key, node)


func _update_key_if_need(key: String) -> String:
	return _create_key_by_parent_key(key)


func _run_action(action_node: GDActionNode, delay: float, speed: float):
	._run_action(action_node, delay, speed)
	action_node.start_run_action(run_action, on_target, is_waiting_finished, delay, speed)


func _prepare_remove_action_node_from_key(key: String):
	run_action._remove_action_node_from_parent_key(key)


func _prepare_pause_action_with_key(key):
	run_action._pause_action_with_parem_key(key)


func _prepare_resume_action_with_key(key: String):
	run_action._resume_action_with_parem_key(key)


func _prepare_cancel_action_with_key(key: String):
	run_action._cancel_action_with_parem_key(key)


func _prepare_finish_action_with_key(key: String):
	run_action._finish_action_with_parem_key(key)


func reversed() -> GDAction:
	return get_script().new(run_action.reversed(), _gd_utils)
