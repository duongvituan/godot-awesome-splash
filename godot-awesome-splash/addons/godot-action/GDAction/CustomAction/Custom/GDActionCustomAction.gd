class_name GDActionCustomAction extends GDActionInterval

var selector: String = ""
var on_target: Node


func _create_action_node(key: String, node):
	var action_node = GDActionNodeCustomAction.new(self, key, node)
	action_node.time_func = time_func
	action_node.ease_func_value = ease_func_value
	return action_node


func _init(selector: String, on_target: Node, duration: float, gd_utils: Node).(duration, gd_utils):
	self.selector = selector
	self.on_target = on_target


func _run_action(action_node: GDActionNode, delay: float, speed: float):
	._run_action(action_node, delay, speed)
	action_node.start_custom_action(self.selector, self.on_target, duration, delay, speed)
