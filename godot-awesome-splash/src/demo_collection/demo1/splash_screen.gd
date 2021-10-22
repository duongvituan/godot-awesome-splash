extends AweSplashScreen

onready var logo := $AspectNode/Logo
onready var info_node := $AspectNode/InfoNode
onready var godot_title := $AspectNode/GodotTitle


const DISTANCE_MOVE = 3000

const FADE_LOGO_TIME = 1.0
const FADE_INFO_TIME = 1.0
const CHARACTERS_RUN_TIME = 3.0
const DELAY_TIME_FOR_EACH_CHARACTER = 0.2


func get_name() -> String:
	return "Demo 1"


func play():
	config()
	start_main_animation()


func config():
	var center_point = self.origin_size / 2.0
	
	logo.position = center_point + Vector2(0, -300)
	logo.scale = Vector2(0.7, 0.7)
	logo.modulate.a = 0
	
	godot_title.position = center_point
	for char_node in godot_title.get_children():
		char_node.position.x -= DISTANCE_MOVE
		char_node.modulate.a = 1
	
	info_node.position = center_point + Vector2(0, 200)
	info_node.modulate.a = 0


func start_main_animation():
	# Animation for logo
	gd.sequence([
		gd.wait(0.5),
		gd.fade_alpha_to(1.0, FADE_LOGO_TIME / 2),
		gd.wait(CHARACTERS_RUN_TIME),
		gd.fade_alpha_to(0.0, FADE_LOGO_TIME / 2),
		gd.wait(0.3),
		gd.perform("finished_animation", self) # finished and move other screen
	]).start(logo)
	
	
	# Animation for charactes GODOT
	var delay = FADE_LOGO_TIME / 2
	for char_node in godot_title.get_children():
		make_action_characters_run(delay).start(char_node)
		delay += DELAY_TIME_FOR_EACH_CHARACTER
	
	
	# Animation For Info node
	gd.sequence([
		gd.wait(FADE_LOGO_TIME + CHARACTERS_RUN_TIME / 3),
		gd.fade_alpha_to(1.0, FADE_INFO_TIME / 2),
		gd.wait(CHARACTERS_RUN_TIME / 3),
		gd.fade_alpha_to(0.0, FADE_INFO_TIME / 2)
	]).start(info_node)


func make_action_characters_run(delay: float) -> GDAction:
	return gd.sequence([
		gd.wait(delay),
		gd.move_by_x(DISTANCE_MOVE -100, CHARACTERS_RUN_TIME / 6),
		gd.move_by_x(200, CHARACTERS_RUN_TIME * 2 / 3),
		gd.move_by_x(DISTANCE_MOVE, CHARACTERS_RUN_TIME / 6)
	])

