class_name GDActionWait extends GDActionInstant

var time: float
var with_range: float


func _init(time: float, with_range: float, gd_utils: Node).(gd_utils):
	self.time = time
	self.with_range = with_range


func _create_action_node(key: String, node):
	return GDActionNodeWait.new(self, key, node)
	

func _run_action(action_node: GDActionNode, delay: float, speed: float):
	._run_action(action_node, delay, speed)
	action_node.wait(time, with_range, delay, speed)

