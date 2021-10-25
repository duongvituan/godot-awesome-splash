extends AweSplashScreen

onready var center_node := $AspectNode/CenterNode
onready var logo := $AspectNode/CenterNode/Logo
onready var godot_sprite := $AspectNode/CenterNode/Logo/Godot
onready var circle := $AspectNode/CenterNode/Logo/Circle
onready var small_circle := $AspectNode/CenterNode/Logo/SmallCircle
onready var info_node := $AspectNode/InfoNode
onready var godot_title_sprite := $AspectNode/GodotTitle

const SHAKE_TEXT_TIME = 0.2
const SPINNY_CIRCE_TIME = 1.5
const FADE_IN_LOGO_TIME = 0.3
const DROP_DOWN_LOGO_TIME = 0.3

const USE_SPINNY_CIRCE = true


func get_name() -> String:
	return "Demo 4"


func play():
	config()
	start_main_animation()


func config():
	var center_point = self.origin_size / 2.0
	
	center_node.position = center_point + Vector2(0, -300)
	if USE_SPINNY_CIRCE:
		logo.position.x = 1500
	logo.scale = Vector2(0.5, 0.5)
	godot_sprite.modulate.a = 0
	
	godot_title_sprite.position = center_point + Vector2(0, 200)
	godot_title_sprite.visible = false
	
	info_node.position = center_point + Vector2(0, 400)
	info_node.modulate.a = 0
	
	small_circle.modulate.a = 1
	
	circle.rect_scale = Vector2(1, 1)
	circle.visible = false
	circle.modulate.a = 1


func start_main_animation():
	var center_point = self.origin_size / 2.0
	
	var spinny_circle_action = gd.sequence([
		gd.run(gd.move_to_x(0, SPINNY_CIRCE_TIME), logo, false),
		gd.rotate_to(360 * 3, SPINNY_CIRCE_TIME)
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
	gd.fade_alpha_to(1, duration).start(godot_sprite)


func shake_text_animation():
	gd.sequence([
		gd.unhide(),
		gd.move_by_y(100, SHAKE_TEXT_TIME / 2.0).with_easing(gd.ease_func.ease_in),
		gd.move_by_y(-100, SHAKE_TEXT_TIME / 2.0).with_easing(gd.ease_func.ease_out)
	]).start(godot_title_sprite)
	
	gd.group([
		gd.unhide(),
		gd.sequence([
			gd.move_by_y(50, SHAKE_TEXT_TIME / 2.0).with_easing(gd.ease_func.ease_in),
			gd.move_by_y(-50, SHAKE_TEXT_TIME / 2.0).with_easing(gd.ease_func.ease_out),
			gd.wait(0.5),
			gd.perform("finished_animation", self)
		]),
		gd.fade_alpha_to(1, SHAKE_TEXT_TIME)
	]).start(info_node)

