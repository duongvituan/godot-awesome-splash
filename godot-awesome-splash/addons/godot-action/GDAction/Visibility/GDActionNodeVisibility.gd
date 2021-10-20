class_name GDActionNodeVisibility extends GDActionNodeInstant

var is_hide: bool

func get_class() -> String:
	return "GDActionNodeVisibility"


func _init(action, key, node).(action, key, node):
	pass


func _start_action():
	node.visible = not is_hide
	finished()


func set_visibility(is_hide: bool, delay = 0.0, speed = 1.0):
	self.is_hide = is_hide
	self.delay = delay
	self.speed = speed
	_reset_value()
	_run()
