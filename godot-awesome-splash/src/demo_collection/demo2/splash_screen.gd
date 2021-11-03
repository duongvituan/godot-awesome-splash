extends AweSplashScreen

onready var logo_container := $AspectNode/LogoContainer
onready var logo := $AspectNode/LogoContainer/Logo
onready var circle := $AspectNode/LogoContainer/Circle
onready var info_node := $AspectNode/InfoNode
onready var title_node := $AspectNode/TitleNode
onready var background := $CanvasLayer/ColorRect


const LOGO_PATH := "res://src/demo_collection/demo2/logo.png"
const TITLE := "GODOT"
const DESCRIPTION := "Game engine"

const SPACE_LOGO_AND_TITLE := 50.0

const BG_COLOR = Color8(0, 0, 0, 255)
const LOGO_COLOR = Color8(255, 255, 255, 255)
const TITLE_COLOR = Color8(255, 255, 255, 255)
const DESCRIPTION_COLOR = Color8(200, 200, 200, 255)

const TITLE_FONT_SIZE = 230
const DESCRIPT_FONT_SIZE = 120

const BALL_JUMP_IN_TIME = 1.0
const BALL_BOUNCE_TIME = 0.3
const JUMP_EACH_CHAR_TIME = 0.4

func get_name() -> String:
	return "Demo 2"


func play():
	_config()
	start_main_animation()


func _config():
	background.color = BG_COLOR
	var center_point = self.origin_size / 2.0
	
	logo_container.modulate = LOGO_COLOR
	logo_container.position = center_point + Vector2(0, 2000)
	logo_container.scale = Vector2(10, 10)
	
	circle.modulate.a = 1
	logo.texture = load_texture(LOGO_PATH)
	logo.modulate.a = 0
	
	# config title
	title_node.font.size = TITLE_FONT_SIZE
	title_node.modulate = TITLE_COLOR
	title_node.text = TITLE
	var shift_x = (SPACE_LOGO_AND_TITLE + logo_size()) / 2.0
	title_node.position = center_point + Vector2(shift_x, -50)
	for child in title_node.get_all_text_node():
		child.modulate.a = 0
	
	# config description
	info_node.font.size = DESCRIPT_FONT_SIZE
	info_node.modulate = DESCRIPTION_COLOR
	info_node.modulate.a = 0
	info_node.text = DESCRIPTION
	info_node.position = center_point + Vector2(0, 150)


func start_main_animation():
	var center_point = self.origin_size / 2.0
	
	var action_jump_and_scale = gd.group([
		gd.sequence([
			gd.move_to_y(center_point.y - 900, BALL_JUMP_IN_TIME / 2.0).with_easing(gd.ease_func.ease_in),
			gd.move_to_y(center_point.y + 75, BALL_JUMP_IN_TIME / 2.0).with_easing(gd.ease_func.ease_out),
		]),
		gd.scale_to(0.4, BALL_JUMP_IN_TIME).with_easing(gd.ease_func.ease_in)
	])
	
	var action_jump_bound = gd.sequence([
		gd.move_to_y(center_point.y - 300, BALL_BOUNCE_TIME / 2.0).with_easing(gd.ease_func.ease_in),
		gd.move_to_y(center_point.y + 75, BALL_BOUNCE_TIME / 2.0).with_easing(gd.ease_func.ease_out),
	])
	
	var shift_x = (title_node.width + SPACE_LOGO_AND_TITLE) / 2.0
	
	return gd.sequence([
		action_jump_and_scale,
		gd.perform("fade_logo_animation", self),
		action_jump_bound,
		gd.wait(0.5),
		gd.move_by_x(-shift_x, 0.3),
		gd.perform("jump_text_animation", self)
	]).start(logo_container)


func fade_logo_animation():
	gd.fade_alpha_to(0, BALL_BOUNCE_TIME).start(circle)
	gd.fade_alpha_to(1, BALL_BOUNCE_TIME).start(logo)


func jump_text_animation():
	var delay = 0.0
	var each_delay_time = 0.25
	var action_char_jump = make_action_jump_character()
	var count = 0.0
	
	for char_node in title_node.get_all_text_node():
		action_char_jump.with_delay(delay).start(char_node)
		delay += each_delay_time
		count += 1.0
		
	gd.sequence([
		gd.wait(each_delay_time * count + JUMP_EACH_CHAR_TIME),
		gd.fade_alpha_to(1.0, 0.5),
		gd.wait(0.8),
		gd.perform("finished_animation", self)
	]).start(info_node)


func make_action_jump_character() -> GDAction:
	return gd.group([
		gd.sequence([
			gd.move_by_y(-150, JUMP_EACH_CHAR_TIME / 2.0).with_easing(gd.ease_func.ease_in),
			gd.move_by_y(150, JUMP_EACH_CHAR_TIME / 2.0).with_easing(gd.ease_func.ease_out)
		]),
		gd.fade_alpha_to(1.0, JUMP_EACH_CHAR_TIME  / 2.0),
		gd.sequence([
			gd.scale_to_vector(Vector2(1.0, 1.4), JUMP_EACH_CHAR_TIME / 2.0),
			gd.scale_to_vector(Vector2(1.2, 0.8), JUMP_EACH_CHAR_TIME / 2.0),
			gd.scale_to_vector(Vector2(1, 1), JUMP_EACH_CHAR_TIME / 4.0),
		])
	])


func logo_size():
	return 280.0
