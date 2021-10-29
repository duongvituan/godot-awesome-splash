class_name GDActionNodePerform extends GDActionNodeInstant

var on_target: Node
var args: Array = []
var selector: String = ""


func get_class() -> String:
	return "GDActionNodePerform"


func _init(action, key, node).(action, key, node):
	pass


func start_perform(selector: String, args: Array, on_target: Node, delay: float, speed: float):
	self.selector = selector
	self.args = args
	self.on_target = on_target
	self.delay = delay
	self.speed = speed
	_reset_value()
	_run()


func _start_action():
	_perform(selector, on_target, args)


func _perform(selector, on_target, args):
	if on_target == null:
		finished()
	
#	on_target.call_deferred(selector)
#	on_target.call(selector)
	on_target.callv(selector, args)
	finished()

