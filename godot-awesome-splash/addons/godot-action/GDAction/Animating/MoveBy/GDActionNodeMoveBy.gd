class_name GDActionNodeMoveBy extends GDActionNodeInterval

var velocity: Vector2 = Vector2.ZERO


func get_class() -> String:
	return "GDActionNodeMoveBy"


func _init(action, key, node):
	super(action, key, node)


func _update(value: float, eased_value: float, delta: float):
	node.position += self.velocity * delta


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

