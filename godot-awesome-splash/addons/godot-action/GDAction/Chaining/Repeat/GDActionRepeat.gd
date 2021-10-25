class_name GDActionRepeat extends GDActionInstant

var count: int = 1
var action: GDAction


func _init(action: GDAction, count: int, gd_utils: Node).(gd_utils):
	self.count = count
	self.action = action


func _create_action_node(key: String, node):
	return GDActionNodeRepeat.new(self, key, node)


func _update_key_if_need(key: String) -> String:
	return _create_key_by_parent_key(key)


func _run_action(action_node: GDActionNode, delay: float, speed: float):
	._run_action(action_node, delay, speed)
	action_node.start_repeat(action, count, delay, speed)


func _prepare_remove_action_node_from_key(key: String):
	action._remove_action_node_from_parent_key(key)


func _prepare_pause_action_with_key(key):
	action._pause_action_with_parem_key(key)


func _prepare_resume_action_with_key(key: String):
	action._resume_action_with_parem_key(key)


func _prepare_cancel_action_with_key(key: String):
	action._cancel_action_with_parem_key(key)


func _prepare_finish_action_with_key(key: String):
	action._finish_action_with_parem_key(key)


func reversed() -> GDAction:
	return get_script().new(action.reversed(), _gd_utils)
