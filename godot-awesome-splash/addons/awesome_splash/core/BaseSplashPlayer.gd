tool
extends Node2D

var splash_screen: BaseSplashScreen setget _set_splash_screen ,_get_splash_screen


func _ready():
	get_viewport().connect("size_changed", self, "update_frame_aspect_node")
	var splash_screen = self.splash_screen
	if splash_screen:
		update_frame_aspect_node()
		self.splash_screen.connect("finished", self, "on_splash_finished")
	


func _get_configuration_warning():
	var warnings = PoolStringArray()
	if not self.splash_screen:
		warnings.append("%s is missing a SplashScreen" % name)
	return warnings.join("\n")


func remove_old_screen():
	for child in get_children():
		remove_child(child)
		child.queue_free()


func _set_splash_screen(screen: BaseSplashScreen):
	remove_old_screen()
	splash_screen = screen
	splash_screen.connect("finished", self, "on_splash_finished")
	add_child(screen)
	update_frame_aspect_node()


func _get_splash_screen() -> BaseSplashScreen:
	for node in get_children():
		if node is BaseSplashScreen:
			return node
	return null


func update_frame_aspect_node():
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


func on_splash_finished():
	print("on_splash_finished")

