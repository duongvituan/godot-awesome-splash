class_name GDActionMoveBy extends GDActionInterval

var vector: Vector2


func _init(vector: Vector2, duration: float, gd_utils: Node).(duration, gd_utils):
	self.vector = vector


func _create_action_node(key: String, node):
	var action_node = GDActionNodeMoveBy.new(self, key, node)
	action_node.time_func = time_func
	action_node.ease_func_value = ease_func_value
	return action_node


func _run_action(action_node: GDActionNode, delay: float, speed: float):
	._run_action(action_node, delay, speed)
	action_node.move_by(vector, duration, delay, speed)


func reversed() -> GDAction:
	return get_script().new(-vector, duration, _gd_utils)
