extends Node2D
class_name BaseSplashScreen, "res://addons/awesome_splash/assets/ss_icon.png"

signal finished

onready var aspect_node := $AspectNode
onready var outline_frame := $AspectNode/OutlineFrame

var origin_size: Vector2  setget , _get_origin_size


func _ready():
	outline_frame.visible = false


func _get_origin_size() -> Vector2:
	return aspect_node.origin_size


func update_aspect_node_frame(parent_size: Vector2):
	aspect_node.parrent_size = parent_size


func get_name() -> String:
	return ""


func play():
	pass


func finished_animation():
	emit_signal("finished")


func skip():
	emit_signal("finished")
