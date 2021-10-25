class_name GDActionNodeInterval extends GDActionNode


var duration = 0.0
var old_eased_value = 0.0


func get_class() -> String:
	return "GDActionNodeInterval"


func _init(action, key, node).(action, key, node):
	pass


func _process(delta):
	if (not is_instance_valid(node)) or duration <= 0.0:
		finished()
		return

	delta *= speed
	
	current_time += delta
	if current_time <= delay:
		return
	
	if current_time > duration + delay:
		# final frame call update
		_update_ease_in(duration, duration + delay + delta - current_time)
		current_time = duration + delay
		finished()
		return
		
	if current_time - delta < delay and current_time > delay:
		# first frame call update
		_update_ease_in(current_time - delay, current_time - delay)
		return
	
	_update_ease_in(current_time - delay, delta)


func _update_ease_in(value: float, delta: float):
	if ease_func_value != null:
		var eased_value = ease(value / duration, ease_func_value)
		_update(eased_value * duration, eased_value, (eased_value - old_eased_value) * duration)
		old_eased_value = eased_value
		
	elif time_func != null:
		var eased_value = time_func.interpolate(value / duration)
		_update(eased_value * duration, eased_value, (eased_value - old_eased_value) * duration)
		old_eased_value = eased_value
		
	else:
		_update(value, value / duration, delta)


# Virtual function
# value: 0.0 -> duration
# eased_value: 0.0 -> 1.0
# delta: new_value - old_value
func _update(value: float, eased_value: float, delta: float):
	pass


func _reset_value():
	._reset_value()
	self.old_eased_value = 0.0
	
