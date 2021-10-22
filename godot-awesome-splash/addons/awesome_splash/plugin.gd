tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("SplashContainer", "Node2D", preload("res://addons/awesome_splash/core/SplashContainer.gd"), preload("res://addons/awesome_splash/assets/splash_container_icon.png"))


func _exit_tree():
	remove_custom_type("SplashContainer")
