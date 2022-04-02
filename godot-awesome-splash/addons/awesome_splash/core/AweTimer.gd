extends Node
class_name AweTimer

signal finished

var max_time: float = 1
var current_time: float = 0


func _ready():
	set_process(false)


func _process(delta):
	current_time += delta
	if current_time >= max_time:
		set_process(false)
		emit_signal("finished")


func wait(time: float):
	current_time = 0
	max_time = time
	set_process(true)


func cancel():
	set_process(false)

