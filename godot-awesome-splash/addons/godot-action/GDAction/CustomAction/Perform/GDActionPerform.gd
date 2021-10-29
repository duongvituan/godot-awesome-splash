class_name GDActionPerform extends GDActionInstant

var selector: String = ""
var args: Array = []
var on_target: Node


func _create_action_node(key: String, node):
	return GDActionNodePerform.new(self, key, node)


func _update_key_if_need(key: String) -> String:
	return _create_key_by_parent_key(key)


func _init(selector: String, args: Array, on_target: Node, gd_utils: Node).(gd_utils):
	self.selector = selector
	self.args = args
	self.on_target = on_target


func _run_action(action_node: GDActionNode, delay: float, speed: float):
	._run_action(action_node, delay, speed)
	action_node.start_perform(self.selector, self.args, self.on_target, delay, speed)

