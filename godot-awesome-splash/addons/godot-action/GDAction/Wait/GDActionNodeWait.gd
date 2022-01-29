class_name GDActionNodeWait extends GDActionNodeInstant

var rng = RandomNumberGenerator.new()

func get_class() -> String:
	return "GDActionNodeWait"


func _init(action, key, node).(action, key, node):
	pass


func _start_action():
	finished()


func wait(time: float, with_range: float, delay = 0.0, speed = 1.0):
	rng.randomize()
	self.delay = rng.randf_range(max(0.0, time - with_range), time + with_range) + delay
	self.speed = speed
	_reset_value()
	_run()
