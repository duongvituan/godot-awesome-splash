tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("sp", "res://addons/awesome_splash/utils_splash.gd")


func _exit_tree():
	remove_autoload_singleton ("sp")
