extends Node


func get_current_splash_container():
	for node in get_tree().root.get_children():
		var container = _find_splash_container_in_node(node)
		if container != null:
			return container
	return null


func _find_splash_container_in_node(node):
	if node is SplashContainer:
		return node
	
	for child in node.get_children():
		return _find_splash_container_in_node(child)
