class_name GDActionFadeAlphaTo extends GDActionInterval

var fade_alpha: float


func _init(fade_alpha: float, duration: float, gd_utils: Node).(duration, gd_utils):
	self.fade_alpha = fade_alpha


func _create_action_node(key: String, node):
	var action_node = GDActionNodeFadeAlphaTo.new(self, key, node)
	action_node.time_func = time_func
	action_node.ease_func_value = ease_func_value
	return action_node


func _run_action(action_node: GDActionNode, delay: float, speed: float):
	._run_action(action_node, delay, speed)
	action_node.fade_alpha_to(fade_alpha, duration, delay, speed)


func reversed() -> GDAction:
	return get_script().new(-fade_alpha, duration, _gd_utils)
