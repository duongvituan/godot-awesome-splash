class_name GDActionNodeFadeAlphaTo extends GDActionNodeInterval

var from_alpha: float = 0.0
var to_alpha: float = 0.0


func get_class() -> String:
	return "GDActionNodeFadeAlphaTo"


func _init(action, key, node).(action, key, node):
	pass


func _update(value: float, eased_value: float, delta: float):
	node.modulate.a = lerp(from_alpha, to_alpha, eased_value)


func fade_alpha_to(alpha_value, duration: float, delay = 0.0, speed = 1.0):
	self.to_alpha = alpha_value
	self.from_alpha = node.modulate.a
	self.duration = duration
	self.delay = delay
	self.speed = speed
	
	_reset_value()
	_run()
