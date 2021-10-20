class_name GDActionNodeRemove extends GDActionNodeInstant

func get_class() -> String:
	return "GDActionNodeRemove"


func _init(action, key, node).(action, key, node):
	pass


func _start_action():
	node.queue_free()
	finished()


func remove_node(time: float, with_range: float, delay = 0.0, speed = 1.0):
	self.delay = delay
	self.speed = speed
	_reset_value()
	_run()
