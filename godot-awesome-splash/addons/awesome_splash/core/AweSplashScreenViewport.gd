class_name AweSplashScreenViewport extends AweSplashScreen

onready var viewport_container := $ViewportContainer
onready var viewport := $ViewportContainer/Viewport

var shader_meterial setget ,_get_shader_meterial

func _ready():
	._ready()


func _get_aspect_node() -> AspectNode:
	if viewport == null:
		return null
	for child in viewport.get_children():
		if child is AspectNode:
			return child
	return null

func update_aspect_node_frame(parent_size: Vector2):
	var aspect_node = self.aspect_node
	if aspect_node == null:
		return
	viewport_container.rect_min_size = parent_size
	viewport_container.rect_size = parent_size
	viewport.size = parent_size
	aspect_node.parrent_size = parent_size


func _get_shader_meterial():
	return viewport_container.material

func _set_shader_f_value(name_value, value):
	self.shader_meterial.set_shader_param(name_value, value)

func _set_shader_color_value(name_value, color):
	self.shader_meterial.set_shader_param(name_value, color)

func _set_shader_texture_value(name_value, texture):
	self.shader_meterial.set_shader_param(name_value, texture)
