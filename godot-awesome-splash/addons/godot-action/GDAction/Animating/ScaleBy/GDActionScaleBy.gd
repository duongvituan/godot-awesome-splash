class_name GDActionScaleBy extends GDActionInterval

var by_vector_scale: Vector2


func _init(by_vector_scale: Vector2, duration: float, gd_utils: Node).(duration, gd_utils):
	self.by_vector_scale = by_vector_scale


func _create_action_node(key: String, node):
	var action_node = GDActionNodeScaleBy.new(self, key, node)
	action_node.time_func = time_func
	action_node.ease_func_value = ease_func_value
	return action_node


func _run_action(action_node: GDActionNode, delay: float, speed: float):
	._run_action(action_node, delay, speed)
	action_node.scale_by(by_vector_scale, duration, delay, speed)


func reversed() -> GDAction:
	return get_script().new(-by_vector_scale, duration, _gd_utils)
