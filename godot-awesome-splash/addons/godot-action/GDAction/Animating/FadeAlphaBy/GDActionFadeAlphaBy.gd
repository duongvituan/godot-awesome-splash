class_name GDActionFadeAlphaBy extends GDActionInterval

var alpha_value: float


func _init(alpha_value: float, duration: float, gd_utils: Node).(duration, gd_utils):
	self.alpha_value = alpha_value


func _create_action_node(key: String, node):
	var action_node = GDActionNodeFadeAlphaBy.new(self, key, node)
	action_node.time_func = time_func
	action_node.ease_func_value = ease_func_value
	return action_node


func _run_action(action_node: GDActionNode, delay: float, speed: float):
	._run_action(action_node, delay, speed)
	action_node.fade_alpha_by(alpha_value, duration, delay, speed)


func reversed() -> GDAction:
	return get_script().new(-alpha_value, duration, _gd_utils)
