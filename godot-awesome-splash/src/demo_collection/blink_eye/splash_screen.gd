extends AweSplashScreen

onready var logo_container := $AspectNode/LogoContainer
onready var logo := $AspectNode/LogoContainer/Logo
onready var godot_left_eye = $AspectNode/LogoContainer/LeftEye
onready var godot_right_eye = $AspectNode/LogoContainer/RightEye

onready var info_node := $AspectNode/InfoNode
onready var title_node := $AspectNode/TitleNode
onready var bg_color := $CanvasLayer/ColorRect


export(String, FILE) var logo_path = "res://src/demo_collection/blink_eye/logo.png"
export(String) var title := "GODOT"
export(String) var description := "Game engine"

export (Color) var background_color = Color8(0, 204, 189, 255)
export (Color) var logo_color =  Color8(255, 255, 255, 255)
export (Color) var font_color := Color.white
export (float) var title_font_size := 230
export (float) var description_font_size := 120


export (float) var duration := 3.0
var fade_time_per_character = 0.2
var text_animation_time = 1.0

const SPACE_LOGO_AND_TITLE := 50.0


const FADE_EYE_TIME = 1.0
const MOVE_TO_LEFT_TIME = 0.2


func get_name() -> String:
	return "Blink Eye"

func _ready():
	config()

func play():
	main_animation()


func config():
	bg_color.color = background_color
	logo.texture = load_texture(logo_path)
	logo.modulate = logo_color
	godot_left_eye.color = background_color
	godot_left_eye.modulate.a = 1.0
	godot_right_eye.color = background_color
	godot_right_eye.modulate.a = 1.0
	
	var center_point = self.origin_size / 2.0
	logo_container.modulate = logo_color
	logo_container.position = center_point + Vector2(0, 50)
	logo_container.scale = Vector2(0.5, 0.5)
	
	# Config TitleNode
	title_node.font.size = title_font_size
	title_node.modulate = font_color
	title_node.text = title
	var shift_x = (SPACE_LOGO_AND_TITLE + logo_size()) / 2.0
	title_node.position = center_point + Vector2(shift_x, -50)
	for child in title_node.get_all_text_node():
		child.modulate.a = 0
	
	# Config InfoNode
	info_node.font.size = description_font_size
	info_node.modulate = font_color
	info_node.text = description
	info_node.position = center_point + Vector2(0, 130)
	info_node.modulate.a = 0
	
	var total_character = title_node.get_all_text_node().size()
	text_animation_time = duration - 0.4 - MOVE_TO_LEFT_TIME - FADE_EYE_TIME
	if total_character == 0:
		total_character = 1.0
		text_animation_time
	
	if text_animation_time <= 0:
		text_animation_time = 1.0
	
	fade_time_per_character = text_animation_time * 0.6 / total_character


func main_animation():
	var shift_x = (title_node.width + SPACE_LOGO_AND_TITLE) / 2.0
	gd.sequence([
		gd.perform("fade_eye_godot_sprite", self),
		gd.wait(FADE_EYE_TIME + 0.2),
		gd.move_by_x(-shift_x, MOVE_TO_LEFT_TIME),
		gd.wait(0.2),
		gd.perform("show_text_animation", self),
	]).start(logo_container)


func fade_eye_godot_sprite():
	var fade_eye_action = gd.fade_alpha_to(0, FADE_EYE_TIME / 2).with_delay(FADE_EYE_TIME / 2)
	fade_eye_action.start(godot_left_eye)
	fade_eye_action.start(godot_right_eye)


func show_text_animation():
	var delay = 0.0
	var time_fade = fade_time_per_character
	var count = 0.0
	
	# Animation Slide Text "Godot"
	for text_node in title_node.get_all_text_node():
		gd.fade_alpha_to(1.0, time_fade).with_delay(delay).start(text_node)
		delay += time_fade
		count += 1.0
	
	# Wail show "Godot" finished and start appear info node
	gd.sequence([
		gd.wait(text_animation_time * 0.6),
		gd.fade_alpha_to(1.0, text_animation_time * 0.2),
		gd.wait(text_animation_time * 0.2 + 0.5),
		gd.perform("finished_animation", self)
	]).start(info_node)


func logo_size():
	return 300.0
