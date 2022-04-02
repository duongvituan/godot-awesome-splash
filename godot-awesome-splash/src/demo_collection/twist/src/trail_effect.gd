extends Line2D

var draw_on_node: Node2D # set from parent
var is_drawing: bool = false
var point = Vector2.ZERO

export var length = 10

func _ready():
	global_position = Vector2.ZERO
	global_rotation = 0
	set_process(false)


func begin_draw_trail():
	is_drawing = true
	set_process(true)

func end_draw_trail():
	is_drawing = false
	gd.fade_alpha_to(0, 0.1).start(self)



func _process(_delta):
	if draw_on_node == null:
		set_process(false)
		return
	
	if is_drawing:
		point = draw_on_node.global_position
		add_point(point)
		
		while get_point_count() > length:
			remove_point(0)
		
	else:
		if get_point_count() > 0:
			remove_point(0)
		else:
			set_process(false)
