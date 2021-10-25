class_name GDActionScaleTo extends GDActionInterval

var vector_scale: Vector2


func _init(vector_scale: Vector2, duration: float, gd_utils: Node).(duration, gd_utils):
	self.vector_scale = vector_scale


func _create_action_node(key: String, node):
	var action_node = GDActionNodeScaleTo.new(self, key, node)
	action_node.time_func = time_func
	action_node.ease_func_value = ease_func_value
	return action_node


func _run_action(action_node: GDActionNode, delay: float, speed: float):
	._run_action(action_node, delay, speed)
	action_node.scale_to(vector_scale, duration, delay, speed)

