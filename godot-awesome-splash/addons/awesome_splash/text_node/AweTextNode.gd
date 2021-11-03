extends Node2D
class_name AweTextNode, "res://addons/awesome_splash/assets/icon/text_node_icon.png"

export var anchor: Vector2
export var font: DynamicFont setget _set_font
export var text: String setget _set_text, _get_text

var label: Label

func _init(anchor: Vector2 = Vector2.ZERO, dynamic_font: DynamicFont = null):
	label = Label.new()
	label.align = 1 # Center
	label.valign = 1 # Center
	label.set("custom_fonts/font", dynamic_font)
	add_child(label)
	self.anchor = anchor
	self.font = dynamic_font


func _ready():
	if font != null:
		label.set("custom_fonts/font", font)
		_update_layout()


func _set_font(value):
	font = value
	label.set("custom_fonts/font", value)
	_update_layout()


func _set_text(value: String):
	text = value
	label.text = value
	_update_layout()
#	update()


func _get_text() -> String:
	return text


#func _draw():
#	draw_rect(Rect2(-5, -5, 10, 10), Color.blue)


func get_true_size() -> Vector2:
	return Vector2(label.rect_size.x, label.rect_size.y * 0.64)


func get_coordinates_top_left_char() -> Vector2:
	var true_size = get_true_size()
	return Vector2(-true_size.x * anchor.x, -true_size.y * anchor.y)


func _update_layout():
	# I don't know why label.rect_size.x alway == 0.0 after set text.
	# I remove and add again to get correct rect_size.x :((
	remove_child(label)
	add_child(label)
	
	var label_rect = label.rect_size
	var true_size = get_true_size()
	
	var x = -(label_rect.x - true_size.x) / 2.0 - true_size.x * anchor.x
	var y = -(label_rect.y - true_size.y) / 2.0 - true_size.y * anchor.y
	label.rect_position = Vector2(x, y)


# CHUA TEST LAI
func update_anchor(new_anchor: Vector2):
	if new_anchor == anchor:
		return
		
	var true_size = get_true_size()
	
	var diff_anchor = new_anchor - anchor
	var shift_x = true_size.x * diff_anchor.x
	var shift_y = true_size.y * diff_anchor.y
	
	label.rect_position.x -= shift_x
	label.rect_position.y -= shift_y
	
	position.x += shift_x
	position.y += shift_y
