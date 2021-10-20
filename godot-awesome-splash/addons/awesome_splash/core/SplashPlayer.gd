tool
extends "res://addons/awesome_splash/core/BaseSplashPlayer.gd"


func _ready():
	play()


# Todo: move to other screen here:
func on_splash_finished():
	print("on_splash_finished")
