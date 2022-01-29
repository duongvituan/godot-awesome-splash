class_name BaseListSplashContainer extends "res://addons/awesome_splash/core/BaseSplashContainer.gd"

signal finished_all


var list_splash_screen = []
var index_play = 0


func _ready():
	for splash_screen in get_children():
		if splash_screen is AweSplashScreen:
			splash_screen.connect("finished", self, "_on_finished_splash_screen")
			list_splash_screen.append(splash_screen)
	
	for splash_screen in list_splash_screen:
		remove_child(splash_screen)


func get_current_splash_screen() -> AweSplashScreen:
	if index_play < list_splash_screen.size():
		return list_splash_screen[index_play]
	return null


func on_next():
	var old_splash_screen = get_current_splash_screen()
	old_splash_screen.queue_free()
	
	index_play += 1
	splash_screen = get_current_splash_screen()
	play_screen(splash_screen)


func play_screen(splash_screen):
	if splash_screen == null:
		emit_signal("finished_all")
		return
	
	self.splash_screen = splash_screen
	play()


func _on_finished_splash_screen():
	print("_on_finished_splash_screen")
	on_next()
