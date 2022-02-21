extends Node2D

signal finished
signal finished_all

var splash_screen: AweSplashScreen
var list_splash_screen = []

var viewport_container: ViewportContainer
var viewport: Viewport

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
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		if _splash_screen_can_be_skipped_when_clicked_screen():
			emit_signal("finished")


### PUBLIC METHODS =============================================================

func remove_old_splash_screen():
	if splash_screen:
		splash_screen.queue_free()

func play_screen(screen):
	splash_screen = screen
	splash_screen.connect("finished", self, "_on_finished_splash_screen")
	viewport.add_child(splash_screen)
	_update_screen_size()
	splash_screen.play()


### VIRTUAL FUNC ===============================================================

func _splash_screen_can_be_skipped_when_clicked_screen() -> bool:
	return false


### PRIVATE METHODS ============================================================

func _setup():
	viewport = Viewport.new()
	viewport_container = ViewportContainer.new()
	add_child(viewport_container)
	viewport_container.add_child(viewport)
	viewport.transparent_bg = true
	viewport.own_world = true
	
	get_viewport().connect("size_changed", self, "_update_screen_size")
	
	for child_node in get_children():
		if child_node is AweSplashScreen:
			list_splash_screen.append(child_node)
	
	for child_node in list_splash_screen:
		remove_child(child_node)

func _update_screen_size():
	if Engine.editor_hint or self.splash_screen == null:
		return 
		
	var viewport_size = get_viewport_rect().size
	viewport.size = viewport_size
	viewport_container.rect_min_size = viewport_size
	viewport_container.rect_size = viewport_size
	self.splash_screen.update_aspect_node_frame(viewport_size)

func _on_finished_splash_screen():
	remove_old_splash_screen()
	
	# Get new splash screen in list
	splash_screen = list_splash_screen.pop_front()
	if splash_screen == null:
		emit_signal("finished")
		emit_signal("finished_all")
		return
	
	emit_signal("finished")
	play_screen(splash_screen)

