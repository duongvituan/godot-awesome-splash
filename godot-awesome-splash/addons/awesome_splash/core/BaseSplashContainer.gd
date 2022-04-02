tool
extends "res://addons/awesome_splash/core/BaseTransitionScreen.gd"

enum SkipScreenType {
	NONE,
	SKIP_ONE_SCREEN_WHEN_CLICKED,
	SKIP_ALL_SCREEN_WHEN_CLICKED,
}

enum SkipCustomNodeType {
	AUTO, # wait in default_custom_node_time and go to next screen
	CUSTOM,
}

signal finished
signal finished_all

var skip_custom_screen_type: int = 0
var skip_screen_type: int = 0

var current_screen
var list_screen = []

var awe_timer = AweTimer.new()
var default_custom_node_time: float = 1.0


### BUILD IN ENGINE METHODS ====================================================

func _get_configuration_warning():
	var warnings = PoolStringArray()
	if get_children().size() == 0:
		warnings.append("%s is missing a AweSplashScreen or Custom Node" % name)
	return warnings.join("\n")


func _ready():
	if Engine.editor_hint:
		return
	_setup()


func _input(event):
	if not _skip_awe_splash_by_event(event):
		return
	
	if _check_current_screen_is_custom() \
			and skip_custom_screen_type == SkipCustomNodeType.CUSTOM:
		return
	
	if skip_screen_type == SkipScreenType.NONE:
		return
	
	if skip_screen_type == \
			SkipScreenType.SKIP_ONE_SCREEN_WHEN_CLICKED:
		status = TransitionStatus.NONE
		awe_timer.cancel()
		_on_finished_animation_screen_disappear()
	
	if skip_screen_type == \
			SkipScreenType.SKIP_ALL_SCREEN_WHEN_CLICKED:
		status = TransitionStatus.NONE
		for screen in list_screen:
			screen.queue_free()
		list_screen = []
		awe_timer.cancel()
		_on_finished_animation_screen_disappear()


func _get(property): # overridden
	if property == "custom_node/type":
		return skip_custom_screen_type
	if property == "custom_node/default_time":
		return default_custom_node_time
	if property == "skip/type":
		return skip_screen_type


func _set(property, value): # overridden
	if property == "custom_node/type":
		skip_custom_screen_type = value
	if property == "custom_node/default_time":
		default_custom_node_time = value
	if property == "skip/type":
		skip_screen_type = value
	
	property_list_changed_notify() # update inspect
	return true


func _get_property_list():
	if not Engine.editor_hint or not is_inside_tree():
		return []
	var property_list = []

	property_list.append(
		{
			"name": "custom_node/type",
			"type": TYPE_INT,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": PoolStringArray(SkipCustomNodeType.keys()).join(","),
		}
	)
	
	if skip_custom_screen_type == SkipCustomNodeType.AUTO:
		property_list.append(
			{
				"name": "custom_node/default_time",
				"type": TYPE_REAL,
				"usage": PROPERTY_USAGE_DEFAULT,
				"hint": PROPERTY_HINT_NONE,
			}
		)
	
	property_list.append(
		{
			"name": "skip/type",
			"type": TYPE_INT,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": PoolStringArray(SkipScreenType.keys()).join(","),
		}
	)
	return property_list


### PUBLIC METHODS =============================================================

func start_play_list_screen():
	var first_screen = list_screen.pop_front()
	if first_screen:
		play_screen(first_screen)
	else:
		emit_signal("finished")
		emit_signal("finished_all")


func play_next_screen():
	_remove_old_screen()
	
	# Get next splash screen and remove it in queue (list_screen)
	var next_screen = list_screen.pop_front()
	if next_screen == null:
		emit_signal("finished")
		emit_signal("finished_all")
		return
	
	emit_signal("finished")
	play_screen(next_screen)


# When you call func "play_screen":
# How it works:
# Presudocode:
# 1 - Run animation screen "appear" (ex: Fade, Diamond, ...).
# 2 - Wait for animation "appear" finished.

# 3 - Run animation of splash screen.
# 4 - Wait for animation of splash finished.

# 5 - Run animation "disappear".
# 6 - Wait for animation "disappear" finished.

# 7 - If the next screen exist in list_screen: call "play_screen" with
# next screen and return to step 1.
# - If the next screen doesn't exist: Emit signal "finished_all".

func play_screen(screen):
	_remove_old_screen()
	screen.visible = true

	current_screen = screen
	viewport.add_child(current_screen)
	
	if screen is AweSplashScreen:
		current_screen.connect(
			"finished",
			self,
			"_on_finished_animation_splash_screen"
		)
	
	_update_screen_size_changed()
	_start_animation_screen_will_appear()


### PRIVATE METHODS ============================================================

func _setup():
	_setup_transition()
	add_child(awe_timer)
	awe_timer.connect("finished", self, "_on_finished_waiting_custom_screen")
	
	for node in get_children():
		if node is AweTimer:
			continue
		
		if node == viewport_container:
			continue
		
		list_screen.append(node)
		remove_child(node)

func _check_current_screen_is_awe_screen():
	return self.current_screen is AweSplashScreen

func _check_current_screen_is_custom():
	return not _check_current_screen_is_awe_screen()


func _update_screen_size_changed():
	if Engine.editor_hint or self.current_screen == null:
		return 
	._update_screen_size_changed()
	
	if not _check_current_screen_is_custom():
		var viewport_size = get_viewport_rect().size
		self.current_screen.update_aspect_node_frame(viewport_size)


func _on_finished_waiting_custom_screen():
	_start_animation_screen_will_disappear()


func _on_finished_animation_splash_screen():
	_start_animation_screen_will_disappear()


func _on_finished_animation_screen_appear():
	._on_finished_animation_screen_appear()
	
	if _check_current_screen_is_awe_screen():
		current_screen.play()
		return
	
	# current screen is custom
	if skip_custom_screen_type == SkipCustomNodeType.CUSTOM:
		return
	
	awe_timer.wait(default_custom_node_time)


func _on_finished_animation_screen_disappear():
	._on_finished_animation_screen_disappear()
	play_next_screen()


func _remove_old_screen():
	if is_instance_valid(current_screen):
		current_screen.queue_free()


func _skip_awe_splash_by_event(event) -> bool:
	return false

