class_name GDActionNodeRotateTo extends GDActionNodeInterval

var from_angle: float
var to_angle: float


func get_class() -> String:
	return "GDActionNodeRotateTo"


func _init(action, key, node).(action, key, node):
	pass


func _update(value: float, eased_value: float, delta: float):
	match node_type:
		NodeType.NODE_2D:
			node.rotation_degrees = lerp(from_angle, to_angle, eased_value)
		
		NodeType.CONTROL:
			node.rect_rotation = lerp(from_angle, to_angle, eased_value)


func action_done():
	if not is_instance_valid(node):
		return
	match node_type:
		NodeType.NODE_2D:
			node.rotation_degrees = fmod(node.rotation_degrees, 360.0)
		
		NodeType.CONTROL:
			node.rect_rotation = fmod(node.rect_rotation, 360.0)


func rotate_to(to_angle: float, duration: float, delay: float, speed: float):
	self.to_angle = to_angle
	self.duration = duration
	self.delay = delay
	self.speed = speed
	
	match node_type:
		NodeType.NODE_2D:
			self.from_angle = node.rotation_degrees
		NodeType.CONTROL:
			self.from_angle = node.rect_rotation
	
	_reset_value()
	_run()

