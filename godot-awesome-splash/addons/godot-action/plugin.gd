tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("gd", "res://addons/godot-action/utils_gd_action.tscn")


func _exit_tree():
	remove_autoload_singleton ("gd")
