## You can download demo splash screen here
## https://github.com/duongvituan/godot-awesome-splash
## Import a demo AweSplashScreen you like to your project.
## Drag and drop it to SplashContainer.
tool
extends "res://addons/awesome_splash/core/BaseSplashContainer.gd"


func _ready():
	play()


# Todo: move to other screen here:
func on_splash_finished():
	print("on_splash_finished")
