extends AweSplashScreen

onready var logo := $AspectNode/Logo
onready var logo_texture := $AspectNode/Logo/Texture
onready var info_node := $AspectNode/InfoNode
onready var title_node := $AspectNode/TitleNode
onready var background := $CanvasLayer/ColorRect


export(String, FILE) var logo_path = "res://src/demo_collection/slide/icon_color.png"
export(String) var title := "GODOT"
export(String) var description := "Game engine"

export (Color) var background_color = Color8(240, 240, 240, 255)
export (Color) var logo_color =  Color8(255, 255, 255, 255)
export (Color) var title_font_color := Color8(56, 57, 58, 255)
export (Color) var description_font_color := Color8(98, 99, 102, 255)
export (float) var title_font_size := 230
export (float) var description_font_size := 120


const DISTANCE_MOVE = 3000
const FADE_LOGO_TIME = 1.0
const FADE_INFO_TIME = 1.0
const CHARACTERS_RUN_TIME = 3.0
const DELAY_TIME_FOR_EACH_CHARACTER = 0.2


func get_name() -> String:
	return "Slide"

func _ready():
	config()

func play():
	start_main_animation()


func config():
	background.color = background_color
	var center_point = self.origin_size / 2.0
	
	logo_texture.texture = load_texture(logo_path)
	logo.position = center_point + Vector2(0, -300)
	logo.modulate.a = 0
	
	title_node.font.size = title_font_size
	title_node.modulate = title_font_color
	title_node.text = title
	title_node.position = center_point + Vector2(0, 50)
	for char_node in title_node.get_all_text_node():
		char_node.position.x -= DISTANCE_MOVE
		char_node.modulate.a = 1
	
	info_node.font.size = description_font_size
	info_node.modulate = description_font_color
	info_node.text = description
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

