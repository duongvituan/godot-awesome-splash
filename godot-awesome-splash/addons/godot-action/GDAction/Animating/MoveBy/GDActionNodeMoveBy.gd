class_name GDActionNodeMoveBy extends GDActionNodeInterval

var velocity: Vector2 = Vector2.ZERO


func get_class() -> String:
	return "GDActionNodeMoveBy"


func _init(action, key, node).(action, key, node):
	pass


func _update(value: float, eased_value: float, delta: float):
	match node_type:
		NodeType.NODE_2D:
			node.position += self.velocity * delta
		
		NodeType.CONTROL:
			node.rect_position += self.velocity * delta


func move_by(vector, duration: float, delay = 0.0, speed = 1.0):
	if duration <= 0:
		finished()
		return
	
	self.velocity = vector / duration
	self.duration = duration
	self.delay = delay
	self.speed = speed
	_reset_value()
	_run()

