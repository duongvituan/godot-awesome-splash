extends Node2D

onready var load_screen := $LoadScreen
onready var splash_player := $SplashPlayer
onready var name_label := $Panel/MarginContainer/VBoxContainer/Label


func _ready():
	var splash_screen = load_screen.get_first_screen().instance()
	update_control_node(splash_screen)
	play_screen(splash_screen)


func _input(event):
	if event.is_action_pressed("next_demo"):
		on_next()
	elif event.is_action_pressed("previous_demo"):
		on_previous()
	elif event.is_action_pressed("reset_demo"):
		on_reset()


func on_reset():
	var splash_screen = load_screen.get_current_screen().instance()
	update_control_node(splash_screen)
	play_screen(splash_screen)


func on_next():
	var splash_screen = load_screen.next().instance()
	update_control_node(splash_screen)
	play_screen(splash_screen)


func on_previous():
	var splash_screen = load_screen.back().instance()
	update_control_node(splash_screen)
	play_screen(splash_screen)


func update_control_node(splash_screen):
	name_label.text = "Name: " + splash_screen.get_name()


func play_screen(splash_screen):
	splash_player.splash_screen = splash_screen
	splash_player.play()
