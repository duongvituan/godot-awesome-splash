class_name GDActionInterval extends GDAction

var duration: float = 0.0

func _init(duration: float, gd_utils: Node):
	super(gd_utils)
	self.duration = duration
