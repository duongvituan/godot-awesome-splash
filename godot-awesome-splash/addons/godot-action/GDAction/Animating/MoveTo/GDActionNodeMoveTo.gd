class_name GDActionNodeMoveTo extends GDActionNodeInterval

enum Type { MOVE_TO, MOVE_TO_X, MOVE_TO_Y }

var type = Type.MOVE_TO

var from_value
var to_value


func get_class() -> String:
	return "GDActionNodeMoveTo"


func _init(action, key, node).(action, key, node):
	pass


func _update(value: float, eased_value: float, delta: float):
	match type:
		Type.MOVE_TO:
			_update_move_to(value, eased_value, delta)
		
		Type.MOVE_TO_X:
			_update_move_to_x(value, eased_value, delta)
		
		Type.MOVE_TO_Y:
			_update_move_to_y(value, eased_value, delta)


func _update_move_to(value: float, eased_value: float, delta: float):
	match node_type:
		NodeType.NODE_2D:
			node.position = lerp(from_value, to_value, eased_value)
		
		NodeType.CONTROL:
			node.rect_position = lerp(from_value, to_value, eased_value)


func _update_move_to_x(value: float, eased_value: float, delta: float):
	match node_type:
		NodeType.NODE_2D:
			node.position.x = lerp(from_value, to_value, eased_value)
		
		NodeType.CONTROL:
			node.rect_position.x = lerp(from_value, to_value, eased_value)


func _update_move_to_y(value: float, eased_value: float, delta: float):
	match node_type:
		NodeType.NODE_2D:
			node.position.y = lerp(from_value, to_value, eased_value)
		
		NodeType.CONTROL:
			node.rect_position.y = lerp(from_value, to_value, eased_value)


func move_to(x, y, duration: float, delay = 0.0, speed = 1.0):
	self.duration = duration
	self.delay = delay
	self.speed = speed
	
	match node_type:
		NodeType.NODE_2D:
			_config_type_node(x, y)
		NodeType.CONTROL:
			_config_type_control(x, y)
	
	_reset_value()
	_run()


func _config_type_node(x, y):
	if x != null and y != null:
		self.from_value = node.position
		self.to_value = Vector2(x, y)
		self.type = Type.MOVE_TO
	
	elif x != null:
		self.from_value = node.position.x
		self.to_value = x
		self.type = Type.MOVE_TO_X
	
	elif y != null:
		self.from_value = node.position.y
		self.to_value = y
		self.type = Type.MOVE_TO_Y
	
	else:
		push_error("GDActionNodeMoveTo much x != null or y != null")
		finished()


func _config_type_control(x, y):
	if x != null and y != null:
		self.from_value = node.rect_position
		self.to_value = Vector2(x, y)
		self.type = Type.MOVE_TO
	
	elif x != null:
		self.from_value = node.rect_position.x
		self.to_value = x
		self.type = Type.MOVE_TO_X
	
	elif y != null:
		self.from_value = node.rect_position.y
		self.to_value = y
		self.type = Type.MOVE_TO_Y
	
	else:
		push_error("GDActionNodeMoveTo much x != null or y != null")
		finished()





