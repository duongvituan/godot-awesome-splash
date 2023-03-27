extends Node2D

@onready var screen_loader := $ScreenLoader
@onready var splash_player := $SplashPlayer
@onready var name_label := $Panel/MarginContainer/VBoxContainer/Label


func _ready():
	var _error = splash_player.finished.connect(self._on_finished_splash_screen)
	var splash_screen = screen_loader.get_first_screen().instantiate() as AweSplashScreen
	update_control_node(splash_screen)
	splash_player.play_screen(splash_screen)


func _input(event):
	if event.is_action_pressed("next_demo"):
		on_next()
	elif event.is_action_pressed("previous_demo"):
		on_previous()
	elif event.is_action_pressed("reset_demo"):
		on_reset()


func on_reset():
	var splash_screen = screen_loader.get_current_screen().instantiate()
	update_control_node(splash_screen)
	splash_player.play_screen(splash_screen)


func on_next():
	var splash_screen = screen_loader.next().instantiate()
	update_control_node(splash_screen)
	splash_player.play_screen(splash_screen)


func on_previous():
	var splash_screen = screen_loader.back().instantiate()
	update_control_node(splash_screen)
	splash_player.play_screen(splash_screen)


func update_control_node(splash_screen: AweSplashScreen):
	name_label.text = "Name: " + splash_screen.get_splash_screen_name()


func _on_finished_splash_screen():
#	on_reset()
	on_next()
