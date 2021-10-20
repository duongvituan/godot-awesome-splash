class_name GDActionNodeFadeAlphaBy extends GDActionNodeInterval

var alpha_velocity: float = 0.0


func get_class() -> String:
	return "GDActionNodeFadeAlphaBy"


func _init(action, key, node).(action, key, node):
	pass


func _update(value: float, eased_value: float, delta: float):
	node.modulate.a += self.alpha_velocity * delta


func fade_alpha_by(alpha_value, duration: float, delay = 0.0, speed = 1.0):
	if duration <= 0:
		finished()
		return
	
	self.alpha_velocity = alpha_value / duration
	self.duration = duration
	self.delay = delay
	self.speed = speed
	_reset_value()
	_run()
