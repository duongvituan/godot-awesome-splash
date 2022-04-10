extends AweSplashScreen

onready var logo_container := $AspectNode/LogoContainer
onready var logo := $AspectNode/LogoContainer/Logo
onready var circle := $AspectNode/LogoContainer/Circle
onready var info_node := $AspectNode/InfoNode
onready var title_node := $AspectNode/TitleNode
onready var background := $CanvasLayer/ColorRect


export(String, FILE) var logo_path = "res://src/demo_collection/circle_jump_01/logo.png"
export(String) var title := "GODOT"
export(String) var description := "Game engine"

export (Color) var background_color = Color8(0, 0, 0, 255)
export (Color) var logo_color =  Color8(255, 255, 255, 255)
export (Color) var font_color := Color.white
export (float) var title_font_size := 230
export (float) var description_font_size := 120

const SPACE_LOGO_AND_TITLE := 50.0
const BALL_JUMP_IN_TIME = 1.0
const BALL_BOUNCE_TIME = 0.3
const JUMP_EACH_CHAR_TIME = 0.4

func get_name() -> String:
	return "Circle Jump 01"

func _ready():
	config()

func play():
	start_main_animation()


func config():
	background.color = background_color
	var center_point = self.origin_size / 2.0
	
	logo_container.modulate = logo_color
	logo_container.position = center_point + Vector2(0, 2000)
	logo_container.scale = Vector2(10, 10)
	
	circle.modulate.a = 1
	logo.texture = load_texture(logo_path)
	logo.modulate.a = 0
	
	# config title
	title_node.font.size = title_font_size
	title_node.modulate = font_color
	title_node.text = title
	var shift_x = (SPACE_LOGO_AND_TITLE + logo_size()) / 2.0
	title_node.position = center_point + Vector2(shift_x, -50)
	for child in title_node.get_all_text_node():
		child.modulate.a = 0
	
	# config description
	info_node.font.size = description_font_size
	info_node.modulate = font_color
	info_node.modulate.a = 0
	info_node.text = description
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
