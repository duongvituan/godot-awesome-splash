extends AweSplashScreen

onready var background := $CanvasLayer/ColorRect
onready var godot := $AspectNode/Godot
onready var sponges := $AspectNode/Sponges

onready var wave1 := $AspectNode/Wave1
onready var wave2 := $AspectNode/Wave2

const COLOR_WAVE1 = Color8(0, 132, 222, 255)
const COLOR_WAVE2 = Color8(255, 255, 255, 255)
const BACKGROUND_COLOR = Color8(255, 255, 255, 255)

const WAVE1_MOVE_UP_TIME = 2.0
const WAVE2_MOVE_UP_TIME = 2.0

const SPONGE_MOVE_X_RANGE = Vector2(-450, 450)
const SPONGE_MOVE_HORIZONTAL_TIME_RANGE = Vector2(5.0, 10.0)
const SPONGE_MOVE_UP_TIME_RANGE = Vector2(5.0, 10.0)

func get_name() -> String:
	return "Demo 5"


func play():
	config()
	start_main_animation()


func config():
	var center_point = self.origin_size / 2.0
	godot.position = center_point + Vector2(0, 300)
	godot.scale = Vector2(1, 1)
	godot.modulate = BACKGROUND_COLOR
	
	background.color = BACKGROUND_COLOR
	wave1.modulate = COLOR_WAVE1
	wave2.modulate = COLOR_WAVE2
	
	sponges.position = Vector2(center_point.x, self.origin_size.y + 1500.0)



func start_main_animation():
	# move up wave 1
	gd.move_by(Vector2(1500, -5000), WAVE1_MOVE_UP_TIME).start(wave1)
	
	
	# move up all sponges
	for sponge in sponges.get_children():
		spoges_move_up(sponge)
	
	
	# wait and move up wave 2
	gd.sequence([
		gd.wait(WAVE1_MOVE_UP_TIME + 0.3),
		gd.move_by(Vector2(1500, -5000), 2.0),
	]).start(wave2)
	
	
	# move up all logo and all sponges in wave2
	var action_move_up = gd.move_by(Vector2(0, -3000), WAVE2_MOVE_UP_TIME).with_easing(0.8)
	gd.sequence([
		gd.wait(WAVE1_MOVE_UP_TIME + 0.7),
		gd.group([
			gd.run(action_move_up, sponges),
			gd.scale_to(0.5, WAVE2_MOVE_UP_TIME * 0.85),
			action_move_up,
		])
	]).start(godot)
	
	gd.sequence([
		gd.wait(WAVE1_MOVE_UP_TIME + WAVE2_MOVE_UP_TIME * 0.8),
		gd.perform("finished_animation", self)
	]).start(self)


func spoges_move_up(sponge: Node2D):
	var range_move = get_random_value(SPONGE_MOVE_X_RANGE)
	var duration_move_sponge = get_random_value(SPONGE_MOVE_HORIZONTAL_TIME_RANGE)
	var duration_up = get_random_value(SPONGE_MOVE_UP_TIME_RANGE)

	gd.move_by_y(-4500, duration_up ).with_easing(0.4).start(sponge)
	gd.move_by_x(range_move, duration_move_sponge).with_easing(0.3).start(sponge.get_child(0))


func get_random_value(ran: Vector2) -> float:
	return (ran.y - ran.x) * randf() + ran.x
