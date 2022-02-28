tool
extends "res://addons/awesome_splash/core/BaseTransitionScreen.gd"

enum SkipScreenType {NONE, SKIP_ONE_SCREEN, SKIP_ALL_SCREEN}

signal finished
signal finished_all

var current_screen
var list_screen = []

var custom_node_player = AweCustomNodePlayer.new()
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
			for screen in list_screen:
				screen.queue_free()
			list_screen = []
			_on_finished_animation_screen_disappear()


func _get(property): # overridden
	if property == "custom_node/default_time":
		return default_custom_node_time


func _set(property, value): # overridden
	if property == "custom_node/default_time":
		trainsition_type = value
	
	property_list_changed_notify() # update inspect
	return true


func _get_property_list():
	if not Engine.editor_hint or not is_inside_tree():
		return []
	
	var property_list = [
		{
			"name": "custom_node/default_time",
			"type": TYPE_REAL,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_NONE,
		}
	]
	return property_list


### PUBLIC METHODS =============================================================

func start_play_list_screen():
	var first_screen = list_screen.pop_front()
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


### VIRTUAL FUNC ===============================================================

func _splash_screen_can_be_skipped_when_clicked_screen() -> int:
	return SkipScreenType.NONE


### PRIVATE METHODS ============================================================

func _setup():
	_setup_transition()
	add_child(custom_node_player)
	custom_node_player.connect("finished", self, "_on_finished_waiting_custom_screen")
	
	for node in get_children():
		if node is AweCustomNodePlayer:
			continue
		
		if node == viewport_container:
			continue
		
		list_screen.append(node)
		remove_child(node)


func _update_screen_size_changed():
	if Engine.editor_hint or self.current_screen == null:
		return 
	._update_screen_size_changed()
	
	if self.current_screen is AweSplashScreen:
		var viewport_size = get_viewport_rect().size
		self.current_screen.update_aspect_node_frame(viewport_size)


func _on_finished_waiting_custom_screen():
	_start_animation_screen_will_disappear()


func _on_finished_animation_splash_screen():
	_start_animation_screen_will_disappear()


func _on_finished_animation_screen_appear():
	._on_finished_animation_screen_appear()
	if self.current_screen is AweSplashScreen:
		current_screen.play()
	else:
		custom_node_player.play(default_custom_node_time)


func _on_finished_animation_screen_disappear():
	._on_finished_animation_screen_disappear()
	_remove_old_screen()
	
	# Get next splash screen and remove it in queue (list_screen)
	var next_screen = list_screen.pop_front()
	if next_screen == null:
		emit_signal("finished")
		emit_signal("finished_all")
		return
	
	emit_signal("finished")
	play_screen(next_screen)


func _remove_old_screen():
	if current_screen:
		current_screen.queue_free()
