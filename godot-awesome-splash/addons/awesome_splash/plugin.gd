tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("SplashPlayer", "Node2D", preload("res://addons/awesome_splash/core/SplashPlayer.gd"), preload("res://addons/awesome_splash/assets/sp_icon.png"))


func _exit_tree():
	remove_custom_type("SplashPlayer")
