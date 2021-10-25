class_name GDActionMoveTo extends GDActionInterval

var x # float or null
var y # float or null


func _init(x, y, duration: float, gd_utils: Node).(duration, gd_utils):
	self.x = x
	self.y = y


func _create_action_node(key: String, node):
	var action_node = GDActionNodeMoveTo.new(self, key, node)
	action_node.time_func = time_func
	action_node.ease_func_value = ease_func_value
	return action_node


func _run_action(action_node: GDActionNode, delay: float, speed: float):
	._run_action(action_node, delay, speed)
	action_node.move_to(x, y, duration, delay, speed)

