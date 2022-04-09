extends AweSplashScreenViewport

onready var logo_container := $ViewportContainer/Viewport/AspectNode/LogoContainer
onready var logo := $ViewportContainer/Viewport/AspectNode/LogoContainer/Logo

onready var info_node := $ViewportContainer/Viewport/AspectNode/InfoNode
onready var title_node := $ViewportContainer/Viewport/AspectNode/TitleNode
onready var bg_color := $CanvasLayer/ColorRect

export(String, FILE) var LOGO_PATH = "res://src/demo_collection/fire/src/logo.png"
export(String) var TITLE := "GODOT"
export(String) var DESCRIPTION := "Game engine"

export (float) var duration := 6.0

const BG_COLOR = Color8(0, 0, 0, 255)
const LOGO_COLOR = Color8(255, 255, 255, 255)
const TITLE_COLOR = Color8(255, 255, 255, 255)
const DESCRIPTION_COLOR = Color8(255, 255, 255, 255)

const TITLE_FONT_SIZE = 230
const DESCRIPT_FONT_SIZE = 120

# config shader hologram
const HOLOGRAM_VALUE = 0.75
const HOLOGRAM_NOISE = 10.0
const HOLOGRAM_SPEED = 1.0
const TINT_COLOR = Color8(59, 235, 38, 255)


func get_name() -> String:
	return "Fire"

func _ready():
	._ready()
	config()


func config():
	bg_color.color = BG_COLOR
	logo.texture = load_texture(LOGO_PATH)
	logo.modulate = LOGO_COLOR
	
	var center_point = self.origin_size / 2.0
	logo_container.modulate = LOGO_COLOR
	logo_container.position = center_point + Vector2(0, -100)
	logo_container.scale = Vector2(0.8, 0.8)
	
	# Config TitleNode
	title_node.font.size = TITLE_FONT_SIZE
	title_node.modulate = TITLE_COLOR
	title_node.text = TITLE
	title_node.position = center_point + Vector2(0, 50)
	
	# Config InfoNode
	info_node.font.size = DESCRIPT_FONT_SIZE
	info_node.modulate = DESCRIPTION_COLOR
	info_node.text = DESCRIPTION
	info_node.position = center_point + Vector2(0, 225)
	

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
