class_name GDActionRotateBy extends GDActionInterval

var by_angle: float


func _init(by_angle: float, duration: float, gd_utils: Node).(duration, gd_utils):
	self.by_angle = by_angle


func _create_action_node(key: String, node):
	var action_node = GDActionNodeRotateBy.new(self, key, node)
	action_node.time_func = time_func
	action_node.ease_func_value = ease_func_value
	return action_node


func _run_action(action_node: GDActionNode, delay: float, speed: float):
	._run_action(action_node, delay, speed)
	action_node.rotate_by(by_angle, duration, delay, speed)


func reversed() -> GDAction:
	return get_script().new(-by_angle, duration, _gd_utils)
