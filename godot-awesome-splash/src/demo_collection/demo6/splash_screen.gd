extends AweSplashScreen

onready var logo := $AspectNode/Logo
onready var godot := $AspectNode/Logo/Godot
onready var circle := $AspectNode/Logo/Circle
onready var shape_node := $AspectNode/Logo/ShapNode

onready var info_node := $AspectNode/InfoNode
onready var godot_char_node := $AspectNode/Title

var custom_func_time = preload("./src/custom.tres")

const LOGO_TO_BALL_TIME = 1.0
const JUMP_IN_TIME = 1.0
const JUMP_BOUNCE_TIME = 1.0

const EASE_IN = 0.25
const EASE_OUT = 4

func get_name() -> String:
	return "Demo 6"


func play():
	config()
	start_main_animation()


func config():
	var center_point = self.origin_size / 2.0
	
	logo.position = center_point + Vector2(0, -200)
	logo.scale = Vector2(5, 5)
	
	circle.modulate.a = 1
	godot.modulate.a = 0
	shape_node.modulate.a = 0
	
	godot_char_node.position = center_point + Vector2(0, 200)

	info_node.position = center_point + Vector2(0, 300)
	info_node.modulate.a = 0


func start_main_animation():
	gd.sequence([
		gd.perform("logo_to_ball", logo, [LOGO_TO_BALL_TIME]),
		gd.wait(LOGO_TO_BALL_TIME),
		action_jump_ball_in(JUMP_IN_TIME),
		gd.perform("show_title_godot", self, [JUMP_BOUNCE_TIME * 0.5]),
		bounce_and_show_logo(JUMP_BOUNCE_TIME),
		gd.perform("shake_character", self, [JUMP_BOUNCE_TIME * 0.3]),
		gd.move_by_y(-100, JUMP_IN_TIME * 0.2).with_easing(EASE_IN)
	]).start(logo)


func action_jump_ball_in(duration: float) -> GDAction:
	var duration_up = duration * 0.55
	var duration_down = duration * 0.45
	
	var center_point = self.origin_size / 2.0 
	
	return gd.group([
		gd.sequence([
			gd.move_to_y(center_point.y - 550, duration_up).with_easing(EASE_IN),
			gd.move_to_y(center_point.y, duration_down).with_easing(EASE_OUT)
		]),
		gd.sequence([
			gd.scale_to(0.8, duration_up * 0.3).with_easing(EASE_IN),
			gd.wait(duration_up * 0.6),
			gd.scale_to(1.2, (duration_up + duration_down) * 0.1).with_easing(EASE_IN)
		]),
		gd.sequence([
			gd.perform("grow_height_to", shape_node, [200.0, duration_up * 0.3, EASE_IN]),
			gd.wait(duration_up * 0.9),
			gd.perform("grow_height_to", shape_node, [1.0, (duration_up + duration_down) * 0.1, EASE_IN]),
			gd.wait(duration_up * 0.1 + duration_down * 0.1),
			gd.perform("grow_height_to", shape_node, [30.0, duration_down * 0.3, EASE_OUT]),
			gd.wait(duration_down * 0.6),
			gd.perform("grow_height_to", shape_node, [1.0, duration_down * 0.1]),
			gd.wait(duration_down * 0.2),
			gd.perform("grow_width_to", shape_node, [20.0, duration_down * 0.1]),
		])
	])


func bounce_and_show_logo(duration: float) -> GDAction:
	var duration_up = duration * 0.55
	var duration_down = duration * 0.45
	
	var center_point = self.origin_size / 2.0

	return gd.group([
		gd.sequence([
			gd.move_to_y(center_point.y - 350, duration_up).with_easing(EASE_IN),
			gd.perform("ball_to_logo", logo, [duration_up * 0.3]),
			gd.move_to_y(center_point.y - 125, duration_down).with_easing(EASE_OUT)
		]),
		gd.sequence([
			gd.perform("grow_width_to", shape_node, [1.0, duration_up * 0.1]),
			gd.wait(duration_up * 0.1),
			gd.perform("grow_height_to", shape_node, [30.0, duration_up * 0.5, EASE_IN]),
			gd.wait(duration_up * 0.8),
			gd.perform("grow_height_to", shape_node, [1.0, (duration_up + duration_down) * 0.1, EASE_OUT]),
			gd.wait(duration_down * 0.1),
			gd.perform("grow_height_to", shape_node, [30.0, duration_down * 0.3, EASE_OUT]),
		])
	])


func show_title_godot(duration: float):
	var delay = 0
	for index in [0, 4, 1, 3, 2]:
		var character_node = godot_char_node.get_child(index).get_child(0)
		gd.sequence([
			gd.wait(delay),
			gd.group([
				gd.move_to(Vector2.ZERO, duration).with_easing(5),
				gd.scale_to(1.0, duration).with_time_func(custom_func_time),
				gd.fade_alpha_to(1, duration).with_easing(2),
			])
		]).start(character_node)
		delay += 0.1


func shake_character(duration):
	gd.sequence([
		gd.unhide(),
		gd.move_by_y(100, duration / 2.0).with_easing(EASE_IN),
		gd.move_by_y(-100, duration / 2.0).with_easing(EASE_OUT)
	]).start(godot_char_node)
	
	gd.group([
		gd.unhide(),
		gd.sequence([
			gd.move_by_y(50, duration / 2.0).with_easing(EASE_IN),
			gd.move_by_y(-50, duration / 2.0).with_easing(EASE_OUT),
			gd.wait(0.5),
			gd.perform("finished_animation", self)
		]),
		gd.fade_alpha_to(1, duration)
	]).start(info_node)

