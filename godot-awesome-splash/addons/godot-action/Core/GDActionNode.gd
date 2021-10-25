class_name GDActionNode extends Node

enum NodeType {
	UNKNOW,
	NODE_2D,
	CONTROL
}

signal finished(action_node)
signal cancelled(action_node)

var delay = 0.0
var current_time = 0.0
var speed = 1.0
var time_func = null
var ease_func_value = null

var key = ""
var action = null

var is_done: bool = false
var is_remove_when_done: bool = false

var node: Node
var node_id: int # use save in cache
var node_type = NodeType.UNKNOW


func _init(action, key: String, node: Node):
	self.action = action
	self.key = key
	self.node = node
	self.node_id = node.get_instance_id()
	
	name = get_class()
	
	if node is Control:
		node_type = NodeType.CONTROL
	elif node is Node2D:
		node_type = NodeType.NODE_2D
	
	connect("finished", action, "_on_action_node_completed")
	connect("cancelled", action, "_on_action_node_cancelled")


func _ready():
	set_process(false)


func action_done():
	pass

func finished():
	set_process(false)
	is_done = true
	action_done()
	emit_signal("finished", self)


func cancel():
	set_process(false)
	is_done = true
	action_done()
	emit_signal("cancelled", self)


func _run():
	is_done = false
	set_process(true)


func pause():
	set_process(false)


func resume():
	set_process(true)


func _reset_value():
	self.current_time = 0.0

# Support debug
func get_class() -> String:
	return "GDActionNode"

