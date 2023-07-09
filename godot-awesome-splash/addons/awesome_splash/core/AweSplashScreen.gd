@icon("res://addons/awesome_splash/assets/icon/splash_screen_icon.png")
@tool
extends Node2D
class_name AweSplashScreen

signal finished

@export var is_skip_appear_transition: bool = false
@export var is_skip_disappear_transition: bool = false

@onready var aspect_node: AspectNode : get = _get_aspect_node
@onready var outline_frame: Control : get = _get_outline_frame

var origin_size: Vector2 : get = _get_origin_size


### BUILD IN ENGINE METHODS ====================================================

func _ready():
	var outline_frame = self.outline_frame
	if outline_frame != null:
		self.outline_frame.visible = false


func _get_configuration_warning():
	var warnings = PackedStringArray()
	if not self.outline_frame:
		warnings.append("%s is missing a AspectNode" % name)
		warnings.append("You can add AspectNode from \"Instance child scene\" button ")
		warnings.append("or you can drag and drop AspectNode.tscn from addons/awesome_splash/")
	return warnings.join("\n")

### PUBLIC METHODS =============================================================

func update_aspect_node_frame(parent_size: Vector2):
	var aspect_node = self.aspect_node
	if aspect_node == null:
		return
	aspect_node.parrent_size = parent_size


func load_texture(path: String):
	var texture = load(path)
	if texture == null:
		push_error("Wasn't able to load the texture located: " + path)
		return 1

	return texture

### PRIVATE METHODS ============================================================


func _get_aspect_node() -> AspectNode:
	for child in get_children():
		if child is AspectNode:
			return child
	return null


func _get_outline_frame() -> Control:
	var aspect_node = self.aspect_node
	
	if aspect_node == null:
		return null
	
	for child in aspect_node.get_children():
		if child.name == "OutlineFrame":
			return child
	return null


func _get_origin_size() -> Vector2:
	var aspect_node = self.aspect_node
	if aspect_node == null:
		return Vector2.ZERO
	return aspect_node.origin_size


func finished_animation():
	emit_signal("finished")


func skip():
	emit_signal("finished")


### VIRTUAL FUNC ===============================================================

func get_splash_screen_name() -> String:
	return ""


func play():
	pass
