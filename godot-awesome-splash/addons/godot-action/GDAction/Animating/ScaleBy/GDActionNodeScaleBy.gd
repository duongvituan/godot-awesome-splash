class_name GDActionNodeScaleBy extends GDActionNodeInterval

var scale_velocity = Vector2.ZERO


func get_class() -> String:
	return "GDActionNodeScaleBy"


func _init(action, key, node).(action, key, node):
	pass


func _update(value: float, eased_value: float, delta: float):
	match node_type:
		NodeType.NODE_2D:
			node.scale += self.scale_velocity * delta
		
		NodeType.CONTROL:
			node.rect_scale += self.scale_velocity * delta


func scale_by(by_vector_scale: Vector2, duration: float, delay: float, speed: float):
	if duration <= 0.0:
		finished()
	
	self.scale_velocity = by_vector_scale / duration
	self.duration = duration
	self.delay = delay
	self.speed = speed
	
	_reset_value()
	_run()

