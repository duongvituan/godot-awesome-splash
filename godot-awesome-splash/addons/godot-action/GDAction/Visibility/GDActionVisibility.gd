class_name GDActionVisibility extends GDActionInstant

var is_hide: bool


func _init(is_hide: bool, gd_utils: Node).(gd_utils):
	self.is_hide = is_hide


func _create_action_node(key: String, node):
	return GDActionNodeVisibility.new(self, key, node)
	

func _run_action(action_node: GDActionNode, delay: float, speed: float):
	._run_action(action_node, delay, speed)
	action_node.set_visibility(is_hide, delay, speed)

