tool
extends "res://addons/awesome_splash/core/BaseTransitionScreen.gd"

enum SkipScreenType {NONE, SKIP_ONE_SCREEN, SKIP_ALL_SCREEN}

signal finished
signal finished_all

var splash_screen: AweSplashScreen
var list_splash_screen = []


### BUILD IN ENGINE METHODS ====================================================

func _get_configuration_warning():
	var warnings = PoolStringArray()
	if not self.splash_screen:
		warnings.append("%s is missing a AweSplashScreen" % name)
	return warnings.join("\n")


func _ready():
	if Engine.editor_hint:
		return
	_setup()


func _input(event):
	if event is InputEventMouseButton \
			and event.pressed \
			and event.button_index == 1:
		var skip_type = _splash_screen_can_be_skipped_when_clicked_screen()
		
		if skip_type == SkipScreenType.NONE:
			return
		
		if skip_type == SkipScreenType.SKIP_ONE_SCREEN:
			status = TransitionStatus.NONE
			_on_finished_animation_screen_disappear()
		
		if skip_type == SkipScreenType.SKIP_ALL_SCREEN:
			status = TransitionStatus.NONE
			for screen in list_splash_screen:
				screen.queue_free()
			list_splash_screen = []
			_on_finished_animation_screen_disappear()


### PUBLIC METHODS =============================================================

func start_play_list_screen():
	var first_screen = list_splash_screen.pop_front()
	if first_screen:
		play_screen(first_screen)
	else:
		emit_signal("finished_all")


# When you call func "play_screen":
# How it works:
# Presudocode:
# 1 - Run animation screen "appear" (ex: Fade, Diamond, ...).
# 2 - Wait for animation "appear" finished.

# 3 - Run animation of splash screen.
# 4 - Wait for animation of splash finished.

# 5 - Run animation "disappear".
# 6 - Wait for animation "disappear" finished.

# 7 - If the next screen exist in list_splash_screen: call "play_screen" with
# next screen and return to step 1.
# - If the next screen doesn't exist: Emit signal "finished_all".

func play_screen(screen):
	_remove_old_screen()
	
	splash_screen = screen
	splash_screen.connect(
		"finished",
		 self,
		 "_on_finished_animation_splash_screen"
	)
	viewport.add_child(splash_screen)
	_update_screen_size_changed()
	_start_animation_screen_will_appear()


### VIRTUAL FUNC ===============================================================

func _splash_screen_can_be_skipped_when_clicked_screen() -> int:
	return SkipScreenType.NONE


### PRIVATE METHODS ============================================================

func _setup():
	_setup_transition()
	
	for child_node in get_children():
		if child_node is AweSplashScreen:
			list_splash_screen.append(child_node)
	
	for child_node in list_splash_screen:
		remove_child(child_node)


func _update_screen_size_changed():
	if Engine.editor_hint or self.splash_screen == null:
		return 
	._update_screen_size_changed()
	var viewport_size = get_viewport_rect().size
	self.splash_screen.update_aspect_node_frame(viewport_size)


func _on_finished_animation_splash_screen():
	_start_animation_screen_will_disappear()


func _on_finished_animation_screen_appear():
	._on_finished_animation_screen_appear()
	splash_screen.play()


func _on_finished_animation_screen_disappear():
	._on_finished_animation_screen_disappear()
	_remove_old_screen()
	
	# Get next splash screen and remove it in queue (list_splash_screen)
	var next_screen = list_splash_screen.pop_front()
	if next_screen == null:
		emit_signal("finished")
		emit_signal("finished_all")
		return
	
	emit_signal("finished")
	play_screen(next_screen)


func _remove_old_screen():
	if splash_screen:
		splash_screen.queue_free()
