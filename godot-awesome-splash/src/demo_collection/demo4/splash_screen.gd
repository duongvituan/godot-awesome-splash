extends AweSplashScreen

onready var center_node := $AspectNode/CenterNode
onready var logo := $AspectNode/CenterNode/Logo
onready var godot_sprite := $AspectNode/CenterNode/Logo/Godot
onready var circle := $AspectNode/CenterNode/Logo/Circle
onready var small_circle := $AspectNode/CenterNode/Logo/SmallCircle
onready var info_node := $AspectNode/InfoNode
onready var godot_title_sprite := $AspectNode/GodotTitle

const SHAKE_TEXT_TIME = 0.2


func get_name() -> String:
	return "Demo 4"


func play():
	config()
	start_main_animation()


func config():
	var center_point = self.origin_size / 2.0
	
	center_node.position = center_point + Vector2(0, -300)
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
	var duration = 1.5
	var duration_move = 0.1
	
	gd.sequence([
		gd.run(gd.move_to_x(0, duration), logo, false),
		gd.rotate_to(360 * 3, duration),
		gd.perform("fade_logo_animation", self),
		gd.wait(0.5),
		gd.move_to(center_point, duration_move).with_time_func(gd.time_func.ease_out),
		gd.perform("wave_animation", self),
		gd.perform("shake_text_animation", self),
		gd.move_by_y(-100, 0.2).with_time_func(gd.time_func.ease_in),
	]).start(center_node)


func wave_animation():
	var duration = 0.3
	gd.sequence([
		gd.group([
			gd.unhide(),
			gd.scale_to(3.0, duration),
			gd.fade_alpha_to(0.1, duration).with_time_func(gd.time_func.ease_in)
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
		gd.move_by_y(100, SHAKE_TEXT_TIME / 2.0).with_time_func(gd.time_func.ease_out),
		gd.move_by_y(-100, SHAKE_TEXT_TIME / 2.0).with_time_func(gd.time_func.ease_in)
	]).start(godot_title_sprite)
	
	gd.group([
		gd.unhide(),
		gd.sequence([
			gd.move_by_y(50, SHAKE_TEXT_TIME / 2.0).with_time_func(gd.time_func.ease_out),
			gd.move_by_y(-50, SHAKE_TEXT_TIME / 2.0).with_time_func(gd.time_func.ease_in),
			gd.wait(0.5),
			gd.perform("finished_animation", self)
		]),
		gd.fade_alpha_to(1, SHAKE_TEXT_TIME)
	]).start(info_node)

