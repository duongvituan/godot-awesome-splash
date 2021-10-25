class_name GDAction extends Reference

signal action_finished()
signal action_cancelled()


var delay = 0.0
var speed = 1.0
var time_func = null
var ease_func_value = null


var _cache_action_node = Dictionary()
var _gd_utils

func _init(gd_utils: Node):
	_gd_utils = gd_utils


# This func needs to be overridden in subclass
func _create_action_node(key: String, node: Node):
	var action_node = GDActionNode.new(self, key, node)
	action_node.time_func = time_func
	action_node.ease_func_value = ease_func_value
	return action_node


# Key is the id of the action-node,
# It determines whether the gd-action needs to be created or reused from the cache.
func _create_key(node: Node) -> String:
	if is_instance_valid(node):
		return String(node.get_instance_id()) + "_" + String(self.get_instance_id())
	return String(self.get_instance_id())


func _create_key_by_parent_key(parent_key: String) -> String:
	return parent_key + "_" + String(self.get_instance_id())

# Key will be updated if this gd-action is a child of chaining-action
func _update_key_if_need(key: String) -> String:
	return key



func _create_action_node_by_key(key: String, node: Node) -> GDActionNode:
	if _cache_action_node.has(key):
		var action_node = _cache_action_node[key]
		if action_node != null:
			return action_node

	var action_node = _create_action_node(key, node)
	_cache_action_node[key] = action_node
	return action_node


# Remove action
func _prepare_remove_action_node_from_key(key: String):
	pass

func _remove_action_node_from_key(key: String):
	_prepare_remove_action_node_from_key(key)
	if _cache_action_node.has(key):
		_cache_action_node[key].queue_free()
		_cache_action_node.erase(key)


func _remove_action_node(action_node: GDActionNode):
	_remove_action_node_from_key(action_node.key)

# This func can be called if this action is a child-action in the chaining-action
func _remove_action_node_from_parent_key(key: String):
	var child_key = _update_key_if_need(key)
	_remove_action_node_from_key(child_key)


# Func start(with_node) is public func.
# The user will use this func to run the action
func start(node: Node):
	var action_key = _create_key(node)
	var action_node = _create_action_node_by_key(action_key, node)
	action_node.is_remove_when_done = true
	_gd_utils._cache.add_action_node(action_node)
	_run_action(action_node, delay, speed)

# This func is called when the action is started from a chaining aciton
func _start_from_action(node: Node, key: String, speed: float) -> GDActionNode:
	var child_key = _update_key_if_need(key)
	var action_node = _create_action_node_by_key(child_key, node)
	_run_action(action_node, delay, self.speed * speed)
	return action_node

# This func needs to be overridden in subclassnode
func _run_action(action_node: GDActionNode, delay: float, speed: float):
	if action_node.get_parent() == null and is_instance_valid(action_node.node):
		if is_instance_valid(_gd_utils):
			_gd_utils._cache.add_child(action_node)
		else:
			action_node.node.get_tree().get_root().add_child(action_node)
	# Pause old action node running
	_pause_action_with_key(action_node.key)


# This method always returns an action object; however, not all actions are reversible.
# When reversed, some actions return an object that either does nothing or 
# that performs the same action as the original action.
func reversed():
	return self


# Function callback when action node complete
func _on_action_node_completed(action_node: GDActionNode):
#	print("_on_action_node_completed: " + action_node.get_class())
	emit_signal("action_finished")
	if action_node.is_remove_when_done:
		_gd_utils._cache.remove_action_node(action_node)
		_remove_action_node(action_node)


func _on_action_node_cancelled(action_node: GDActionNode):
#	print("_on_action_node_cancelled: " + action_node.get_class())
	emit_signal("action_cancelled")
	if action_node.is_remove_when_done:
		_gd_utils._cache.remove_action_node(action_node)
		_remove_action_node(action_node)


# Config property action
func with_delay(delay: float) -> GDAction:
	self.delay = delay
	return self


func with_speed(speed: float) -> GDAction:
	self.speed = speed
	return self


func with_time_func(time_func: Curve) -> GDAction:
	self.time_func = time_func
	return self


func with_easing(ease_func_value: float) -> GDAction:
	self.ease_func_value = ease_func_value
	return self

# Stop action

# Need override, used to pause dependent action nodes (ex: list_node in sequence or group...)
func _prepare_pause_action_with_key(key: String):
	pass


func _pause_action_with_key(key: String):
	_prepare_pause_action_with_key(key)
	if _cache_action_node.has(key):
		_cache_action_node[key].pause()


func _pause_action_with_parem_key(key: String):
	var child_key = _update_key_if_need(key)
	_pause_action_with_key(child_key)


func pause_action_on_node(node: Node):
	var key = _create_key(node)
	_pause_action_with_key(key)


func pause_all():
	for key in _cache_action_node:
		_pause_action_with_key(key)


# Resume action

# Need override, used to resume dependent action nodes (ex: list_node in sequence or group...)
func _prepare_resume_action_with_key(key: String):
	pass


func _resume_action_with_key(key: String):
	_prepare_resume_action_with_key(key)
	if _cache_action_node.has(key):
		_cache_action_node[key].resume()


func _resume_action_with_parem_key(key: String):
	var child_key = _update_key_if_need(key)
	_resume_action_with_key(child_key)


func resume_action_on_node(node: Node):
	var key = _create_key(node)
	_resume_action_with_key(key)


func resume_all():
	for key in _cache_action_node:
		_resume_action_with_key(key)

# Cancelled action

# Need override, used to cancel dependent action nodes (ex: list_node in sequence or group...)
func _prepare_cancel_action_with_key(key: String):
	pass


func _cancel_action_with_key(key: String):
	_prepare_cancel_action_with_key(key)
	if _cache_action_node.has(key):
		_cache_action_node[key].cancel()


func _cancel_action_with_parem_key(key: String):
	var child_key = _update_key_if_need(key)
	_cancel_action_with_key(child_key)


func cancel_action_on_node(node: Node):
	var key = _create_key(node)
	_cancel_action_with_key(key)


func cancel_all():
	for key in _cache_action_node:
		_cancel_action_with_key(key)


# Finish action

# Need override, used to finish dependent action nodes (ex: list_node in sequence or group...)
func _prepare_finish_action_with_key(key: String):
	pass


func _finish_action_with_key(key: String):
	_prepare_finish_action_with_key(key)
	if _cache_action_node.has(key):
		_cache_action_node[key].finished()


func _finish_action_with_parem_key(key: String):
	var child_key = _update_key_if_need(key)
	_finish_action_with_key(child_key)


func finish_action_on_node(node: Node):
	var key = _create_key(node)
	_finish_action_with_key(key)


func finish_all():
	for key in _cache_action_node:
		_finish_action_with_key(key)
