extends AweSplashScreen

onready var trail_node := $Trail2D

onready var title_node := $AspectNode/TitleNode
onready var info_node := $AspectNode/InfoNode
onready var background := $CanvasLayer/ColorRect

onready var center_node := $AspectNode/CenterNode
onready var logo_container := $AspectNode/CenterNode/LogoContainer
onready var logo := $AspectNode/CenterNode/LogoContainer/Logo
onready var circle := $AspectNode/CenterNode/LogoContainer/Circle
onready var small_circle := $AspectNode/CenterNode/LogoContainer/SmallCircle


export(String, FILE) var logo_path = "res://src/demo_collection/twist/src/logo.png"
export(String) var title := "GODOT"
export(String) var description := "Game engine"

export (Color) var background_color = Color8(0, 0, 0, 255)
export (Color) var logo_color =  Color8(255, 255, 255, 255)
export (Color) var font_color := Color.white
export (float) var title_font_size := 230
export (float) var description_font_size := 120


const SHAKE_TEXT_TIME = 0.2
const SPINNY_CIRCE_TIME = 1.5
const FADE_IN_LOGO_TIME = 0.3
const DROP_DOWN_LOGO_TIME = 0.3
const PREPARE_MOVE_OTHER_SCREEN = 0.75

const USE_SPINNY_CIRCE = true
const USE_TRAIL_EFFTECT = true


func get_name() -> String:
	return "Twist"


func _ready():
	config()


func play():
	start_main_animation()


func config():
	background.color = background_color
	var center_point = self.origin_size / 2.0
	
	center_node.position = center_point + Vector2(0, -300)
	if USE_SPINNY_CIRCE:
		logo_container.position.x = 1500
	logo_container.scale = Vector2(0.5, 0.5)
	logo_container.modulate = logo_color
	logo.texture = load_texture(logo_path)
	logo.modulate.a = 0
	
	# config title node
	title_node.font.size = title_font_size
	title_node.modulate = font_color
	title_node.text = title
	title_node.position = center_point + Vector2(0, 200)
	title_node.visible = false
	
	#config info node
	info_node.font.size = description_font_size
	info_node.text = description
	info_node.modulate = font_color
	info_node.position = center_point + Vector2(0, 400)
	info_node.modulate.a = 0
	
	small_circle.modulate.a = 1
	
	circle.rect_scale = Vector2(1, 1)
	circle.visible = false
	circle.modulate.a = 1
	
	if USE_TRAIL_EFFTECT:
		trail_node.draw_on_node = logo_container
		trail_node.modulate = logo_color



func start_main_animation():
	var center_point = self.origin_size / 2.0
	
	var spinny_circle_action = gd.sequence([
		gd.perform("begin_draw_trail", trail_node),
		gd.run(gd.move_to_x(0, SPINNY_CIRCE_TIME), logo_container, false),
		gd.rotate_to(360 * 3, SPINNY_CIRCE_TIME),
		gd.perform("end_draw_trail", trail_node)
	])
	
	var appear_logo_action = gd.sequence([
		gd.perform("fade_logo_animation", self),
		gd.wait(FADE_IN_LOGO_TIME + 0.2),
		gd.move_to(center_point, DROP_DOWN_LOGO_TIME / 3).with_easing(gd.ease_func.ease_in),
		gd.perform("wave_animation", self),
		gd.perform("shake_text_animation", self),
		gd.move_by_y(-100, DROP_DOWN_LOGO_TIME * 2 / 3).with_easing(gd.ease_func.ease_out),
	])
	
	if USE_SPINNY_CIRCE:
		gd.sequence([
			spinny_circle_action,
			appear_logo_action
		]).start(center_node)
	else:
		appear_logo_action.start(center_node)


func wave_animation():
	gd.sequence([
		gd.group([
			gd.unhide(),
			gd.scale_to(3.0, FADE_IN_LOGO_TIME).with_easing(gd.ease_func.ease_in),
			gd.fade_alpha_to(0.1, FADE_IN_LOGO_TIME).with_easing(gd.ease_func.ease_in)
		]),
		gd.hide()
	]).start(circle)


func fade_logo_animation():
	var duration = 0.3
	gd.fade_alpha_to(0, duration).start(small_circle)
	gd.fade_alpha_to(1, duration).start(logo)


func shake_text_animation():
	gd.sequence([
		gd.unhide(),
		gd.move_by_y(100, SHAKE_TEXT_TIME / 2.0).with_easing(gd.ease_func.ease_in),
		gd.move_by_y(-100, SHAKE_TEXT_TIME / 2.0).with_easing(gd.ease_func.ease_out)
	]).start(title_node)
	
	gd.group([
		gd.unhide(),
		gd.sequence([
			gd.move_by_y(50, SHAKE_TEXT_TIME / 2.0).with_easing(gd.ease_func.ease_in),
			gd.move_by_y(-50, SHAKE_TEXT_TIME / 2.0).with_easing(gd.ease_func.ease_out),
			gd.wait(PREPARE_MOVE_OTHER_SCREEN),
			gd.perform("finished_animation", self)
		]),
		gd.fade_alpha_to(1, SHAKE_TEXT_TIME)
	]).start(info_node)

