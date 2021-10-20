class_name GDActionNodeColorize extends GDActionNodeInterval

var is_self_modulate: bool
var from_color: Color
var to_color: Color


func get_class() -> String:
	return "GDActionNodeColorize"


func _init(action, key, node).(action, key, node):
	pass


func _update(value: float, eased_value: float, delta: float):
	if is_self_modulate:
		node.self_modulate = lerp(from_color, to_color, eased_value)
	else:
		node.modulate = lerp(from_color, to_color, eased_value)


func colorize(color: Color, is_self_modulate: bool, duration: float, delay = 0.0, speed = 1.0):
	self.to_color = color
	self.from_color = node.self_modulate if is_self_modulate else node.modulate
	self.is_self_modulate = is_self_modulate
	self.duration = duration
	self.delay = delay
	self.speed = speed
	
	_reset_value()
	_run()
