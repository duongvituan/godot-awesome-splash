extends AweSplashScreen

onready var logo_container := $AspectNode/LogoContainer
onready var logo := $AspectNode/LogoContainer/Logo
onready var circle := $AspectNode/LogoContainer/Circle
onready var shape_node := $AspectNode/LogoContainer/ShapNode
onready var background := $CanvasLayer/ColorRect
onready var info_node := $AspectNode/InfoNode
onready var title_node := $AspectNode/TitleNode

export(String, FILE) var logo_path = "res://src/demo_collection/circle_jump_02/src/logo.png"
export(String) var title := "GODOT"
export(String) var description := "Game engine"

export (Color) var background_color = Color8(0, 0, 0, 255)
export (Color) var logo_color =  Color8(255, 255, 255, 255)
export (Color) var font_color := Color.white
export (float) var title_font_size := 230
export (float) var description_font_size := 120


const LOGO_TO_BALL_TIME = 1.0
const JUMP_IN_TIME = 1.0
const JUMP_BOUNCE_TIME = 1.0

const EASE_IN = 0.25
const EASE_OUT = 4


var list_origin_position: Array = []
var custom_func_time = preload("./src/custom.tres")

func get_name() -> String:
	return "Circle Jump 02"


func _ready():
	config()

func play():
	start_main_animation()


func config():
	background.color = background_color
	var center_point = self.origin_size / 2.0
	
	logo_container.modulate = logo_color
	logo_container.position = center_point + Vector2(0, -200)
	logo_container.scale = Vector2(5, 5)
	
#	circle.modulate.a = 1
	logo.texture = load_texture(logo_path)
	logo.modulate.a = 0
	shape_node.modulate.a = 0
	
	
	# Config Title Node
	title_node.font.size = title_font_size
	title_node.modulate = font_color
	title_node.text = title
	title_node.position = center_point + Vector2(0, 200)
	title_node.update_all_anchor(make_list_custom_anchor(title))
	var width = title_node.width
	for text_node in title_node.get_all_text_node():
		list_origin_position.append(text_node.position)
		text_node.position.x = width / 2.0
		text_node.scale = Vector2.ZERO
		text_node.modulate.a = 0.0
	
	
	# Config Info Node
	info_node.font.size = description_font_size
	info_node.modulate = font_color
	info_node.modulate.a = 0
	info_node.text = description
	info_node.position = center_point + Vector2(0, 300)


func start_main_animation():
	gd.sequence([
		gd.perform("logo_to_ball", logo_container, [LOGO_TO_BALL_TIME]),
		gd.wait(LOGO_TO_BALL_TIME),
		action_jump_ball_in(JUMP_IN_TIME),
		gd.perform("show_title_godot", self, [JUMP_BOUNCE_TIME * 0.5]),
		bounce_and_show_logo(JUMP_BOUNCE_TIME),
		gd.perform("shake_character", self, [JUMP_BOUNCE_TIME * 0.3]),
		gd.move_by_y(-100, JUMP_IN_TIME * 0.2).with_easing(EASE_IN)
	]).start(logo_container)


# OMG, I don't understand what i'm coding this demo :((.
# But looking at the animation results, i found a bit of fun :]].
# So i will not remove this demo.
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
			gd.perform("ball_to_logo", logo_container, [duration_up * 0.3]),
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
	var count = float(title.length())
	if count == 0:
		return
	var list_index_priority = make_custom_range(count)
	
	for index in list_index_priority:
		var text_node = title_node.get_all_text_node()[index]
		gd.sequence([
			gd.wait(delay),
			gd.group([
				gd.move_to(list_origin_position[index], duration).with_easing(5),
				gd.scale_to(1.0, duration).with_time_func(custom_func_time),
				gd.fade_alpha_to(1, duration).with_easing(2),
			])
		]).start(text_node)
		delay += duration / count


func shake_character(duration):
	gd.sequence([
		gd.unhide(),
		gd.move_by_y(100, duration / 2.0).with_easing(EASE_IN),
		gd.move_by_y(-100, duration / 2.0).with_easing(EASE_OUT)
	]).start(title_node)
	
	gd.group([
		gd.unhide(),
		gd.sequence([
			gd.move_by_y(50, duration / 2.0).with_easing(EASE_IN),
			gd.move_by_y(-50, duration / 2.0).with_easing(EASE_OUT),
			gd.wait(1.0),
			gd.perform("finished_animation", self)
		]),
		gd.fade_alpha_to(1, duration)
	]).start(info_node)


func make_custom_range(number: int) -> Array:
	var output = []
	for i in number / 2:
		output.append(i)
		output.append(number - 1 - i)
	
	if number % 2 == 1:
		output.append(number / 2)
	return output


func make_list_custom_anchor(text: String):
	var output = []
	var count = text.length()
	var is_odd = count % 2 == 1
	
	for i in count:
		if is_odd:
			if i < count / 2:
				output.append(Vector2(1.0, 1.0))
			elif i == count / 2:
				output.append(Vector2(0.5, 1.0))
			else:
				output.append(Vector2(0.0, 1.0))
		else:
			if i < count / 2 :
				output.append(Vector2(1.0, 1.0))
			else:
				output.append(Vector2(0.0, 1.0))
	return output
