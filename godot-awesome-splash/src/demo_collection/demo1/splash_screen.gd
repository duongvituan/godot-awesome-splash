extends AweSplashScreen

onready var logo := $AspectNode/Logo
onready var logo_texture := $AspectNode/Logo/Texture
onready var info_node := $AspectNode/InfoNode
onready var title_node := $AspectNode/TitleNode
onready var background := $CanvasLayer/ColorRect


const LOGO_PATH := "res://src/demo_collection/demo1/icon_color.png"
const TITLE := "GODOT"
const DESCRIPTION := "Game engine"

const TITLE_FONT_SIZE = 230
const DESCRIPT_FONT_SIZE = 120

const BG_COLOR = Color8(240, 240, 240, 255)
const TITLE_COLOR = Color8(56, 57, 58, 255)
const DESCRIPTION_COLOR = Color8(98, 99, 102, 255)

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
	background.color = BG_COLOR
	var center_point = self.origin_size / 2.0
	
	logo_texture.texture = load_texture(LOGO_PATH)
	logo.position = center_point + Vector2(0, -300)
	logo.modulate.a = 0
	
	title_node.font.size = TITLE_FONT_SIZE
	title_node.modulate = TITLE_COLOR
	title_node.text = TITLE
	title_node.position = center_point + Vector2(0, 50)
	for char_node in title_node.get_all_text_node():
		char_node.position.x -= DISTANCE_MOVE
		char_node.modulate.a = 1
	
	info_node.font.size = DESCRIPT_FONT_SIZE
	info_node.modulate = DESCRIPTION_COLOR
	info_node.text = DESCRIPTION
	info_node.position = center_point + Vector2(0, 250)
	info_node.modulate.a = 0


func start_main_animation():
	# Animation for logo
	gd.sequence([
		gd.wait(0.5),
		gd.fade_alpha_to(1.0, FADE_LOGO_TIME / 2).with_easing(0.5),
		gd.wait(CHARACTERS_RUN_TIME),
		gd.fade_alpha_to(0.0, FADE_LOGO_TIME / 2).with_easing(2),
		gd.wait(0.3),
		gd.perform("finished_animation", self) # finished and move other screen
	]).start(logo)
	
	
	# Animation for charactes GODOT
	var delay = FADE_LOGO_TIME / 2
	for char_node in title_node.get_reverse_text_node():
		make_action_characters_run(delay).start(char_node)
		delay += DELAY_TIME_FOR_EACH_CHARACTER
	
	
	# Animation For Info node
	gd.sequence([
		gd.wait(FADE_LOGO_TIME + CHARACTERS_RUN_TIME / 3),
		gd.fade_alpha_to(1.0, FADE_INFO_TIME / 2).with_easing(0.5),
		gd.wait(CHARACTERS_RUN_TIME / 3),
		gd.fade_alpha_to(0.0, FADE_INFO_TIME / 2).with_easing(2)
	]).start(info_node)


func make_action_characters_run(delay: float) -> GDAction:
	return gd.sequence([
		gd.wait(delay),
		gd.move_by_x(2 * DISTANCE_MOVE, CHARACTERS_RUN_TIME).with_easing(-0.15)
	])

