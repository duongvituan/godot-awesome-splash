## You can download demo splash screen here
## https://github.com/duongvituan/godot-awesome-splash
## Import a demo AweSplashScreen you like to your project.
## Drag and drop it to SplashContainer.
tool
extends "res://addons/awesome_splash/core/BaseListSplashContainer.gd"


func _ready():
	if not Engine.editor_hint:
		connect("finished_all", self, "_on_finished_all_splash_screen")
		splash_screen = get_current_splash_screen()
		play_screen(splash_screen)


# Set true if you want click to skip screen
func _splash_screen_can_be_skipped_when_clicked_screen() -> bool:
	return false


# Todo: move to other screen here:
func _on_finished_all_splash_screen():
	get_tree().change_scene("res://Main.tscn")
