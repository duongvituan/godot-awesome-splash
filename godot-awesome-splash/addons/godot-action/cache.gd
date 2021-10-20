extends Node

var cache_running_action: Dictionary = {}


func pause_all_action():
	for action_node in get_all_action_node():
		action_node.action.pause_all()


func pause_all_action_on_node(node: Node):
	var node_id = node.get_instance_id()
	
	if not cache_running_action.has(node_id):
		return
	
	var list_action_node_running = cache_running_action[node_id]
	for action_node in list_action_node_running:
		action_node.action.pause_action_on_node(node)


func pause_action_on_node(node: Node, action: GDAction):
	action.pause_action_on_node(node)


func resume_all_action():
	for action_node in get_all_action_node():
		action_node.action.resume_all()


func resume_all_action_on_node(node: Node):
	var node_id = node.get_instance_id()

	if not cache_running_action.has(node_id):
		return

	var list_action_node_running = cache_running_action[node_id]
	for action_node in list_action_node_running:
		action_node.action.resume_action_on_node(node)


func resume_action_on_node(node: Node, action: GDAction):
	action.resume_action_on_node(node)


func cancel_all_action():
	for action_node in get_all_action_node():
		action_node.action.cancel_all()


func cancel_all_action_on_node(node: Node):
	var node_id = node.get_instance_id()

	if not cache_running_action.has(node_id):
		return

	var list_action_node_running = cache_running_action[node_id]
	for action_node in list_action_node_running:
		action_node.action.cancel_action_on_node(node)


func cancel_action_on_node(node: Node, action: GDAction):
	action.cancel_action_on_node(node)


func finish_all_action():
	for action_node in get_all_action_node():
		action_node.action.finish_all()


func finish_all_action_on_node(node: Node):
	var node_id = node.get_instance_id()

	if not cache_running_action.has(node_id):
		return

	var list_action_node_running = cache_running_action[node_id]
	for action_node in list_action_node_running:
		action_node.action.finish_action_on_node(node)


func finish_action_on_node(node: Node, action: GDAction):
	action.finish_action_on_node(node)


func get_all_action_node():
	var output = []
	for node_id in cache_running_action:
		for action_node in cache_running_action[node_id]:
			output.append(action_node)
	return output


func add_action_node(action_node: GDActionNode):
	var node_id = action_node.node_id
	var list_action_node_running_on_node = []
	
	if cache_running_action.has(node_id):
		list_action_node_running_on_node = cache_running_action[node_id]
		
	if not list_action_node_running_on_node.has(action_node):
		list_action_node_running_on_node.append(action_node)
		
	cache_running_action[node_id] = list_action_node_running_on_node


func remove_action_node(action_node: GDActionNode):
	var node_id = action_node.node_id
	if cache_running_action.has(node_id):
		cache_running_action[node_id].erase(action_node)
		if cache_running_action[node_id].size() == 0:
			cache_running_action.erase(node_id)

