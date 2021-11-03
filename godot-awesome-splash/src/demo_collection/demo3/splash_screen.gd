extends AweSplashScreen

onready var logo_container := $AspectNode/LogoContainer
onready var logo := $AspectNode/LogoContainer/Logo
onready var godot_left_eye = $AspectNode/LogoContainer/LeftEye
onready var godot_right_eye = $AspectNode/LogoContainer/RightEye

onready var info_node := $AspectNode/InfoNode
onready var title_node := $AspectNode/TitleNode
onready var bg_color := $CanvasLayer/ColorRect


const LOGO_PATH := "res://src/demo_collection/demo3/logo.png"
const TITLE := "GODOT"
const DESCRIPTION := "Game engine"

const SPACE_LOGO_AND_TITLE := 50.0

const BG_COLOR = Color8(0, 204, 189, 255)
const LOGO_COLOR = Color8(255, 255, 255, 255)
const TITLE_COLOR = Color8(255, 255, 255, 255)
const DESCRIPTION_COLOR = Color8(255, 255, 255, 255)

const TITLE_FONT_SIZE = 230
const DESCRIPT_FONT_SIZE = 120


const FADE_EYE_TIME = 1.0
const MOVE_TO_LEFT_TIME = 0.2
const FADE_TIME_PER_GODOT_TEXT = 0.2


func get_name() -> String:
	return "Demo 3"


func play():
	config()
	main_animation()


func config():
	bg_color.color = BG_COLOR
	logo.texture = load_texture(LOGO_PATH)
	logo.modulate = LOGO_COLOR
	godot_left_eye.color = BG_COLOR
	godot_left_eye.modulate.a = 1.0
	godot_right_eye.color = BG_COLOR
	godot_right_eye.modulate.a = 1.0
	
	var center_point = self.origin_size / 2.0
	logo_container.modulate = LOGO_COLOR
	logo_container.position = center_point + Vector2(0, 50)
	logo_container.scale = Vector2(0.5, 0.5)
	
	# Config TitleNode
	title_node.font.size = TITLE_FONT_SIZE
	title_node.modulate = TITLE_COLOR
	title_node.text = TITLE
	var shift_x = (SPACE_LOGO_AND_TITLE + logo_size()) / 2.0
	title_node.position = center_point + Vector2(shift_x, -50)
	for child in title_node.get_all_text_node():
		child.modulate.a = 0
	
	# Config InfoNode
	info_node.font.size = DESCRIPT_FONT_SIZE
	info_node.modulate = DESCRIPTION_COLOR
	info_node.text = DESCRIPTION
	info_node.position = center_point + Vector2(0, 130)
	info_node.modulate.a = 0


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
	var time_fade = FADE_TIME_PER_GODOT_TEXT
	var count = 0.0
	
	# Animation Slide Text "Godot"
	for text_node in title_node.get_all_text_node():
		gd.fade_alpha_to(1.0, time_fade).with_delay(delay).start(text_node)
		delay += time_fade
		count += 1.0
	
	# Wail show "Godot" finished and start appear info node
	gd.sequence([
		gd.wait(time_fade * count),
		gd.fade_alpha_to(1.0, 0.5),
		gd.wait(0.5),
		gd.perform("finished_animation", self)
	]).start(info_node)


func logo_size():
	return 300.0
