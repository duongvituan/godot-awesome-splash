## You can download demo splash screen here
## https://github.com/duongvituan/godot-awesome-splash
## Import a demo AweSplashScreen you like to your project.
## Drag and drop it to SplashContainer.
tool
extends "res://addons/awesome_splash/core/BaseSplashContainer.gd"
class_name SplashContainer, "res://addons/awesome_splash/assets/icon/splash_container_icon.png"

func _ready():
	if not Engine.editor_hint:
		connect("finished_all", self, "_on_finished_all_splash_screen")
		start_play_list_screen()


# Todo: Change skippable screen here:
func _splash_screen_can_be_skipped_when_clicked_screen() -> int:
# return SkipScreenType.SKIP_ONE_SCREEN if you want 1 click then skip 1 screen.
# return SkipScreenType.SKIP_ALL_SCREEN if you want 1 click will go to main screen.
	return SkipScreenType.NONE


# Todo: move to other screen here:
func _on_finished_all_splash_screen():
	print("_on_finished_all_splash_screen")
#	get_tree().change_scene("res://Main.tscn")
