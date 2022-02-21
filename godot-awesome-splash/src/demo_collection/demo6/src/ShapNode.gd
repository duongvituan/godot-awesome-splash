extends Node2D

onready var line2d := $Line2D

var origin_width = 0
var origin_height = 0

var to_width = 0
var to_height = 0

var is_growing = true


func grow_height_to(height: float, duration: float, ease_value: float = 1.0):
	origin_height = abs(line2d.get_point_position(0).y - line2d.get_point_position(1).y)
	to_height = height
	is_growing = to_height > origin_height
	gd.custom_action("_update_grow_height", self, duration).with_easing(ease_value).start(self)


func _update_grow_height(_value: float, eased_value: float, _delta: float):
	var point1 = line2d.get_point_position(0)
	var point2 = line2d.get_point_position(1)
	point1.x = 0
	point2.x = 0
	
	if is_growing:
		point1.y = -eased_value * to_height / 2.0
		point2.y = 0.01 + eased_value * to_height / 2.0
	else:
		point1.y = -(origin_height + 0.01) / 2.0 + eased_value * (origin_height - to_height) / 2.0
		point2.y = (origin_height + 0.01) / 2.0 - eased_value * (origin_height - to_height) / 2.0
	
	line2d.set_point_position(0, point1)
	line2d.set_point_position(1, point2)


func grow_width_to(width: float, duration: float, ease_value: float = 1.0):
	origin_width = abs(line2d.get_point_position(0).x - line2d.get_point_position(1).x)
	to_width = width
	is_growing = to_width > origin_width
	gd.custom_action("_update_grow_width", self, duration).with_easing(ease_value).start(self)


func _update_grow_width(_value: float, eased_value: float, _delta: float):
	var point1 = line2d.get_point_position(0)
	var point2 = line2d.get_point_position(1)
	point1.y = 0
	point2.y = 0
	
	if is_growing:
		point1.x = -eased_value * to_width / 2.0
		point2.x = 0.01 + eased_value * to_width / 2.0
	else:
		point1.x = -(origin_width + 0.01) / 2.0 + eased_value * (origin_width - to_width) / 2.0
		point2.x = (origin_width + 0.01) / 2.0 - eased_value * (origin_width - to_width) / 2.0
	
	line2d.set_point_position(0, point1)
	line2d.set_point_position(1, point2)

