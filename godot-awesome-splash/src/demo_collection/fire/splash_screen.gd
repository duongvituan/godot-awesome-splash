extends AweSplashScreenViewport

onready var logo_container := $ViewportContainer/Viewport/AspectNode/LogoContainer
onready var logo := $ViewportContainer/Viewport/AspectNode/LogoContainer/Logo

onready var info_node := $ViewportContainer/Viewport/AspectNode/InfoNode
onready var title_node := $ViewportContainer/Viewport/AspectNode/TitleNode
onready var bg_color := $CanvasLayer/ColorRect

export(String, FILE) var logo_path = "res://src/demo_collection/fire/src/logo.png"
export(String) var title := "GODOT"
export(String) var description := "Game engine"

export (float) var duration := 6.0
export (Color) var background_color = Color8(0, 0, 0, 255)
export (Color) var vfx_color = Color8(255, 60, 15, 255)

export (float) var title_font_size := 230
export (float) var description_font_size := 120

var logo_color =  Color8(255, 255, 255, 255)
var font_color := Color.white


func get_name() -> String:
	return "Fire"

func _ready():
	._ready()
	config()


func config():
	bg_color.color = background_color
	logo.texture = load_texture(logo_path)
	logo.modulate = logo_color
	
	var center_point = self.origin_size / 2.0
	logo_container.modulate = logo_color
	logo_container.position = center_point + Vector2(0, -100)
	logo_container.scale = Vector2(0.8, 0.8)
	
	# Config TitleNode
	title_node.font.size = title_font_size
	title_node.modulate = font_color
	title_node.text = title
	title_node.position = center_point + Vector2(0, 50)
	
	# Config InfoNode
	info_node.font.size = description_font_size
	info_node.modulate = font_color
	info_node.text = description
	info_node.position = center_point + Vector2(0, 225)
	
	config_shader()


func config_shader():
	_set_shader_color_value("burn_color", vfx_color)


func play():
	main_animation()

func main_animation():
	gd.sequence([
		gd.perform("animation_appear", self),
		gd.wait(duration * 0.5),
		gd.perform("animation_disappear", self),
		gd.wait(duration * 0.5),
		gd.perform("finished_animation", self)
	])\
	.start(self)

var noise_tex1 = preload("./src/noise1.png")
var noise_tex2 = preload("./src/noise2.png")

func animation_appear():
	_set_shader_texture_value("noise_tex", noise_tex2)
	_set_shader_f_value("process_value", 1.0)
	gd.custom_action("update_appear", self, duration * 0.5).with_easing(1.5).start(self)

func animation_disappear():
	_set_shader_texture_value("noise_tex", noise_tex1)
	_set_shader_f_value("process_value", 0.0)
	gd.custom_action("update_disappear", self, duration * 0.5).with_easing(3.0).start(self)


func update_disappear(_value: float, eased_value: float, _delta: float):
	_set_shader_f_value("process_value", eased_value)

func update_appear(_value: float, eased_value: float, _delta: float):
	_set_shader_f_value("process_value", 1.0 - eased_value)
