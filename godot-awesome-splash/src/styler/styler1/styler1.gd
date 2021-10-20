extends BaseSplashScreen

onready var logo := $AspectNode/Logo
onready var godot := $AspectNode/Logo/Godot
onready var circle := $AspectNode/Logo/Circle
onready var info_node := $AspectNode/InfoNode
onready var godot_char_node := $AspectNode/Godot


func get_name() -> String:
	return "Styler 1"


func play():
	config()
	start_main_animation()


func config():
	var center_point = self.origin_size / 2.0
	
	logo.position = center_point + Vector2(0, 2000)
	logo.scale = Vector2(10, 10)
	
	info_node.position = center_point + Vector2(0, 200)
	info_node.modulate.a = 0
	
	circle.modulate.a = 1
	godot.modulate.a = 0
	
	godot_char_node.position = center_point + Vector2(200, 0)
	for child in godot_char_node.get_children():
		child.modulate.a = 0
		child.position.y = 100


func start_main_animation():
	var duration = 1.0
	var action_jump_bounce_logo = make_action_jump_ball(duration)
	action_jump_bounce_logo.start(logo)


func fade_logo_animation():
	gd.fade_alpha_to(0, 0.3).start(circle)
	gd.fade_alpha_to(1, 0.3).start(godot)


func jump_text_animation():
	var delay = 0.0
	var action_char_jump = make_action_jump_character()
	
	for char_node in godot_char_node.get_children():
		action_char_jump.with_delay(delay).start(char_node)
		delay += 0.25
		
	gd.sequence([
		gd.wait(1.5),
		gd.fade_alpha_to(1.0, 0.5),
		gd.wait(0.5),
		gd.perform("finished_animation", self)
	]).start(info_node)


func make_action_jump_ball(duration: float) -> GDAction:
	var center_point = self.origin_size / 2.0
	
	var action_jump_and_scale = gd.group([
		gd.sequence([
			gd.move_to_y(center_point.y - 900, duration / 2.0).with_time_func(gd.time_func.ease_out),
			gd.move_to_y(center_point.y + 100, duration / 2.0).with_time_func(gd.time_func.ease_in),
		]),
		gd.scale_to(0.4, duration).with_time_func(gd.time_func.ease_out)
	])
	
	var action_jump_bound = gd.sequence([
		gd.move_to_y(center_point.y - 200, duration / 2.0 * 0.3).with_time_func(gd.time_func.ease_out),
		gd.move_to_y(center_point.y + 100, duration / 2.0 * 0.2).with_time_func(gd.time_func.ease_in),
	])
	
	return gd.sequence([
		action_jump_and_scale,
		gd.perform("fade_logo_animation", self),
		action_jump_bound,
		gd.wait(0.5),
		gd.move_by_x(-350, 0.3),
		gd.perform("jump_text_animation", self)
	])


func make_action_jump_character() -> GDAction:
	var duration = 0.2
	var action_jump_character = gd.sequence([
		gd.move_by_y(-150, duration).with_time_func(gd.time_func.ease_in),
		gd.move_by_y(150, duration).with_time_func(gd.time_func.ease_out)
	])
	
	var action_scale_character = gd.sequence([
		gd.scale_to_vector(Vector2(1.0, 1.4), duration),
		gd.scale_to_vector(Vector2(1.2, 0.8), duration),
		gd.scale_to_vector(Vector2(1, 1), duration / 4),
	])
	
	return gd.group([
		action_jump_character,
		gd.fade_alpha_to(1.0, duration),
		action_scale_character
	])
