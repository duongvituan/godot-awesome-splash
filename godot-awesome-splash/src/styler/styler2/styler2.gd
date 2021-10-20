extends BaseSplashScreen

onready var godot_icon := $AspectNode/GodotIcon
onready var godot_left_eye = $AspectNode/GodotIcon/LeftEye
onready var godot_right_eye = $AspectNode/GodotIcon/RightEye
onready var info_node := $AspectNode/InfoNode
onready var godot_char_node := $AspectNode/Godot
onready var bg_color := $CanvasLayer/ColorRect

const BG_COLOR = Color8(0, 204, 189, 255)
const FADE_EYE_TIME = 1.0
const MOVE_TO_LEFT_TIME = 0.2
const FADE_TIME_PER_GODOT_TEXT = 0.2


func get_name() -> String:
	return "Styler 2"


func play():
	config()
	main_animation()


func config():
	bg_color.color = BG_COLOR
	godot_left_eye.color = BG_COLOR
	godot_left_eye.modulate.a = 1.0
	godot_right_eye.color = BG_COLOR
	godot_right_eye.modulate.a = 1.0
	
	var center_point = self.origin_size / 2.0
	godot_icon.position = center_point
	godot_icon.scale = Vector2(0.5, 0.5)
	godot_char_node.position = center_point + Vector2(200, 0)
	
	info_node.position = godot_char_node.position + Vector2(-200, 200)
	info_node.modulate.a = 0
	for child in godot_char_node.get_children():
		child.modulate.a = 0


func main_animation():
	gd.sequence([
		gd.perform("fade_eye_godot_sprite", self),
		gd.wait(FADE_EYE_TIME + 0.2),
		gd.move_by_x(-400, MOVE_TO_LEFT_TIME),
		gd.wait(0.2),
		gd.perform("show_text_animation", self),
	]).start(godot_icon)


func fade_eye_godot_sprite():
	var fade_eye_action = gd.fade_alpha_to(0, FADE_EYE_TIME / 2).with_delay(FADE_EYE_TIME / 2)
	fade_eye_action.start(godot_left_eye)
	fade_eye_action.start(godot_right_eye)


func show_text_animation():
	var delay = 0.0
	var time_fade = FADE_TIME_PER_GODOT_TEXT
	
	# Animation Slide Text "Godot"
	for character_node in godot_char_node.get_children():
		gd.fade_alpha_to(1.0, time_fade).with_delay(delay).start(character_node)
		delay += time_fade
	
	# Wail show "Godot" finished and start appear info node
	gd.sequence([
		gd.wait(time_fade * 5),
		gd.fade_alpha_to(1.0, 0.5),
		gd.wait(0.5),
		gd.perform("finished_animation", self)
	]).start(info_node)

