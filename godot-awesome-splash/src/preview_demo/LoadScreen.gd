class_name LoadScreen extends Node

var styler0 = preload("res://src/styler/styler0/styler0.tscn")
var styler1 = preload("res://src/styler/styler1/styler1.tscn")
var styler2 = preload("res://src/styler/styler2/styler2.tscn")
var styler3 = preload("res://src/styler/styler3/styler3.tscn")

var index = 0

func get_list():
	return [styler0, styler1, styler2, styler3]


func get_first_screen():
	index = 0
	return get_list()[0]

func get_current_screen():
	return get_list()[index]

func next():
	var list = get_list()
	index = (index + 1) % list.size()
	return list[index]


func back():
	var list = get_list()
	index = (index + list.size() - 1) % list.size()
	return list[index]
