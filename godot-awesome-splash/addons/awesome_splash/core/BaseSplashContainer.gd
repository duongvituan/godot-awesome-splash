extends Node2D

signal finished

var splash_screen: AweSplashScreen setget _set_splash_screen ,_get_splash_screen


func _ready():
	if Engine.editor_hint:
		return
	
	get_viewport().connect("size_changed", self, "update_frame_aspect_node")
	_config_splash_screen_it_exits()


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		if _splash_screen_can_be_skipped_when_clicked_screen():
			emit_signal("finished")


func _splash_screen_can_be_skipped_when_clicked_screen() -> bool:
	return false


func _get_configuration_warning():
	var warnings = PoolStringArray()
	if not self.splash_screen:
		warnings.append("%s is missing a AweSplashScreen" % name)
	return warnings.join("\n")


func _remove_old_screen():
	for child in get_children():
		remove_child(child)
		child.queue_free()


func _config_splash_screen_it_exits():
	var splash_screen = self.splash_screen
	if splash_screen != null:
		update_frame_aspect_node()
		self.splash_screen.connect("finished", self, "_on_splash_animation_finished")


func _set_splash_screen(screen: AweSplashScreen):
	_remove_old_screen()
	add_child(screen)
	_config_splash_screen_it_exits()


func _get_splash_screen() -> AweSplashScreen:
	for node in get_children():
		if node is AweSplashScreen:
			return node
	return null


func update_frame_aspect_node():
	if Engine.editor_hint:
		return 
	
	var current_splash_screen = self.splash_screen
	if current_splash_screen == null:
		return

	var viewport_size = get_viewport_rect().size
	current_splash_screen.update_aspect_node_frame(viewport_size)


func play():
	var current_splash_screen = self.splash_screen
	if current_splash_screen == null:
		return
	current_splash_screen.play()


func _on_splash_animation_finished():
	emit_signal("finished")

