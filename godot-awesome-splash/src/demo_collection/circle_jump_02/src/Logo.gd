extends Node2D

onready var logo := $Logo
onready var circle := $Circle
onready var shape_node := $ShapNode

var EASE_IN = 0.3
var EASE_OUT = 3.0

func logo_to_ball(duration):
	gd.sequence([
		gd.fade_alpha_to(1.0, duration * 0.8).with_easing(EASE_IN),
		gd.fade_alpha_to(0.0, duration * 0.2).with_easing(EASE_OUT)
	]).start(logo)
	
	gd.sequence([
		gd.wait(duration * 0.8),
		gd.fade_alpha_to(1.0, duration * 0.2).with_easing(EASE_OUT)
	]).start(shape_node)


func ball_to_logo(duration):
	gd.sequence([
		gd.fade_alpha_to(1.0, duration * 0.5).with_easing(EASE_IN),
		gd.scale_to(3.0, duration * 0.5).with_easing(EASE_IN)
	]).start(logo)
	
	gd.fade_alpha_to(0.0, duration * 0.5).start(shape_node)
	
	gd.sequence([
		gd.group([
			gd.unhide(),
			gd.scale_to(3.0, duration).with_easing(EASE_IN),
			gd.fade_alpha_to(0.1, duration).with_easing(EASE_IN)
		]),
		gd.hide()
	]).start(circle)

