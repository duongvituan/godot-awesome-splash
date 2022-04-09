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


# Working only for screen type AweSplashScreen and you much set
# type skip = SKIP_ONE_SCREEN_WHEN_CLICKED or SKIP_ALL_SCREEN_WHEN_CLICKED
# Todo: update condition skip splash screen: when you click, when you press key...
func _skip_awe_splash_by_event(event) -> bool:
	return event is InputEventMouseButton \
			and event.pressed \
			and event.button_index == 1


# Todo: move to other screen here:
func _on_finished_all_splash_screen():
	if move_to_scene != null:
		get_tree().change_scene_to(move_to_scene)
	else:
		push_error("Please set move_to_scene in SplashContainer")
