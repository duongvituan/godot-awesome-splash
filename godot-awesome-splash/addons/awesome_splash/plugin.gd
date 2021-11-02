tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("SplashContainer", "Node2D", preload("./core/SplashContainer.gd"), preload("./assets/icon/splash_container_icon.png"))


func _exit_tree():
	remove_custom_type("SplashContainer")
