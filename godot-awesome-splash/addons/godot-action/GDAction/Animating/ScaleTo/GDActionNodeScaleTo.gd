class_name GDActionNodeScaleTo extends GDActionNodeInterval

var from_scale = Vector2.ZERO
var to_scale = Vector2.ZERO


func get_class() -> String:
	return "GDActionNodeScaleTo"


func _init(action, key, node).(action, key, node):
	pass


func _update(value: float, eased_value: float, delta: float):
	match node_type:
		NodeType.NODE_2D:
			node.scale = lerp(from_scale, to_scale, eased_value)
		
		NodeType.CONTROL:
			node.rect_scale = lerp(from_scale, to_scale, eased_value)


func scale_to(vector_scale: Vector2, duration: float, delay: float, speed: float):
	if duration <= 0.0:
		finished()
	
	self.to_scale = vector_scale
	self.duration = duration
	self.delay = delay
	self.speed = speed
	
	match node_type:
		NodeType.NODE_2D:
			self.from_scale = node.scale
		NodeType.CONTROL:
			self.from_scale = node.rect_scale
	
	_reset_value()
	_run()

