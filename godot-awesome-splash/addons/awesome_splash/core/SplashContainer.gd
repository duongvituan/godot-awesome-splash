## You can download demo splash screen here
## https://github.com/duongvituan/godot-awesome-splash
## Import a demo AweSplashScreen you like to your project.
## Drag and drop it to SplashContainer.
tool
extends "res://addons/awesome_splash/core/BaseSplashContainer.gd"


func _ready():
	if not Engine.editor_hint:
		play()


# Todo: move to other screen here:
func _on_splash_animation_finished():
	print("_on_splash_animation_finished")
