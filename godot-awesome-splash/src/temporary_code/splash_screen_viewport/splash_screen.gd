extends AweSplashScreenViewport

onready var logo_container := $ViewportContainer/Viewport/AspectNode/LogoContainer
onready var logo := $ViewportContainer/Viewport/AspectNode/LogoContainer/Logo

onready var info_node := $ViewportContainer/Viewport/AspectNode/InfoNode
onready var title_node := $ViewportContainer/Viewport/AspectNode/TitleNode
onready var bg_color := $CanvasLayer/ColorRect

const LOGO_PATH := "res://src/temporary_code/splash_screen_viewport/logo.png"
const TITLE := "GODOT"
const DESCRIPTION := "Game engine"


const BG_COLOR = Color8(0, 0, 0, 255)
const LOGO_COLOR = Color8(255, 255, 255, 255)
const TITLE_COLOR = Color8(255, 255, 255, 255)
const DESCRIPTION_COLOR = Color8(255, 255, 255, 255)

const TITLE_FONT_SIZE = 230
const DESCRIPT_FONT_SIZE = 120

func get_splash_screen_name() -> String:
	return "Zoom"

func _ready():
	._ready()


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
	config()
	main_animation()

func main_animation():
	pass

