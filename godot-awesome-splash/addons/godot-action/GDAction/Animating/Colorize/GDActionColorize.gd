class_name GDActionColorize extends GDActionInterval

var color: Color
var is_self_modulate: bool

func _init(color: Color, is_self_modulate: bool, duration: float, gd_utils: Node).(duration, gd_utils):
	self.color = color
	self.is_self_modulate = is_self_modulate


func _create_action_node(key: String, node):
	var action_node = GDActionNodeColorize.new(self, key, node)
	action_node.time_func = time_func
	action_node.ease_func_value = ease_func_value
	return action_node


func _run_action(action_node: GDActionNode, delay: float, speed: float):
	._run_action(action_node, delay, speed)
	action_node.colorize(color, is_self_modulate, duration, delay, speed)
