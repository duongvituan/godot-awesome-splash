class_name GDActionNodeCustomAction extends GDActionNodeInterval

var on_target: Node
var selector: String = ""


func get_class() -> String:
	return "GDActionNodeCustomAction"


func _init(action, key, node).(action, key, node):
	pass


func _update(value: float, eased_value: float, delta: float):
	on_target.call(selector, value, eased_value, delta)


func start_custom_action(selector: String, on_target: Node, duration: float, delay = 0.0, speed = 1.0):
	if duration <= 0:
		finished()
		return
	
	self.selector = selector
	self.on_target = on_target
	self.duration = duration
	self.delay = delay
	self.speed = speed
	_reset_value()
	_run()
