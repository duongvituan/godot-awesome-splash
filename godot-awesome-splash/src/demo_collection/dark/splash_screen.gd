extends AweSplashScreenViewport

onready var logo_container := $ViewportContainer/Viewport/AspectNode/LogoContainer
onready var logo := $ViewportContainer/Viewport/AspectNode/LogoContainer/Logo

onready var info_node := $ViewportContainer/Viewport/AspectNode/InfoNode
onready var title_node := $ViewportContainer/Viewport/AspectNode/TitleNode
onready var bg_color := $CanvasLayer/ColorRect

export(String, FILE) var LOGO_PATH = "res://src/demo_collection/dark/src/logo.png"
export(String) var TITLE := "GODOT"
export(String) var DESCRIPTION := "Game engine"

export (float) var duration := 4.0

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
	return "Dark"

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
	
	config_shader()
	
	logo_container.modulate.a = 0
	title_node.modulate.a = 0
	info_node.modulate.a = 0


func config_shader():
	_set_shader_f_value("hologram_value", HOLOGRAM_VALUE)
	_set_shader_f_value("hologram_noise_x", HOLOGRAM_NOISE)
	_set_shader_f_value("hologram_speed", HOLOGRAM_SPEED)
	_set_shader_color_value("tint_color", TINT_COLOR)
	

func play():
	main_animation()

func main_animation():
	gd.fade_alpha_to(1, 1).with_delay(duration * 0.1).start(logo_container)
	gd.fade_alpha_to(1, 1).with_delay(duration * 0.25).start(title_node)
	gd.fade_alpha_to(1, 1).with_delay(duration * 0.4).start(info_node)
	
	gd.sequence([
		gd.wait(duration),
		gd.fade_alpha_to(0.0, duration * 0.2),
		gd.perform("finished_animation", self) # finished and move other screen
	])\
	.start(self.aspect_node)

