extends Node

onready var ease_func: GDEaseFunc = $ease_func
onready var _cache = $cache

# Animating a Node's Position in a Linear Path
# Animate linear node movement.
func move_to(target_position: Vector2, duration: float) -> GDAction:
	return GDActionMoveTo.new(target_position.x, target_position.y, duration, self)


func move_to_x(x: float, duration: float) -> GDAction:
	return GDActionMoveTo.new(x, null, duration, self)


func move_to_y(y: float, duration: float) -> GDAction:
	return GDActionMoveTo.new(null, y, duration, self)


func move_by(vector: Vector2, duration: float) -> GDAction:
	return GDActionMoveBy.new(vector, duration, self)


func move_by_x(x: float, duration: float) -> GDAction:
	return GDActionMoveBy.new(Vector2(x, 0), duration, self)


func move_by_y(y: float, duration: float) -> GDAction:
	return GDActionMoveBy.new(Vector2(0, y), duration, self)


# Animating the Rotation of a Node
func rotate_by(by_angle: float, duration: float) -> GDAction:
	return GDActionRotateBy.new(by_angle, duration, self)


func rotate_to(to_angle: float, duration: float) -> GDAction:
	return GDActionRotateTo.new(to_angle, duration, self)


# Animating the Scaling of a Node
# Animate the visual scaling of a node.
func scale_by(scale: float, duration: float) -> GDAction:
	return GDActionScaleBy.new(Vector2(scale, scale), duration, self)


func scale_by_vector(vector_scale: Vector2, duration: float) -> GDAction:
	return GDActionScaleBy.new(vector_scale, duration, self)


func scale_to(scale: float, duration: float) -> GDAction:
	return GDActionScaleTo.new(Vector2(scale, scale), duration, self)


func scale_to_vector(vector_scale: Vector2, duration: float) -> GDAction:
	return GDActionScaleTo.new(vector_scale, duration, self)


# Animating the Transparency of a Node
# Gradually change a node's transparency.
func fade_alpha_by(alpha_value: float, duration: float) -> GDAction:
	return GDActionFadeAlphaBy.new(alpha_value, duration, self)


func fade_alpha_to(alpha_value: float, duration: float) -> GDAction:
	return GDActionFadeAlphaTo.new(alpha_value, duration, self)


# Creates an animation change color.

# Func colorize change color only node
func colorize(color: Color, duration: float) -> GDAction:
	return GDActionColorize.new(color, true, duration, self)

# Func colorize_all change color node and child node
func colorize_all(color: Color, duration: float) -> GDAction:
	return GDActionColorize.new(color, false, duration, self)

# Removing a Node from the Scene
func remove_node() -> GDAction:
	return GDActionRemove.new(self)


# Chaining Actions
# Create an action that contains a series, or chain, of other actions.

# A group action has multiple child actions.
# All actions stored in the group begin executing at the same time.
func group(list_action: Array) -> GDActionGroup:
	return GDActionGroup.new(list_action, self)

# A sequence action has multiple child actions.
# Each action in the sequence begins after the previous action ends.
func sequence(list_action: Array) -> GDAction:
	return GDActionSequence.new(list_action, self)

# A repeating action stores a single child action.
# When the child action completes, it is restarted.
func repeat(action: GDAction, count: int) -> GDAction:
	return GDActionRepeat.new(action, count, self)


func repeat_forever(action: GDAction) -> GDAction:
	return GDActionRepeatForever.new(action, self)


# Delaying Actions
# Creates an action that idles for a randomized period of time.
func wait(time: float, with_range: float = 0.0) -> GDAction:
	return GDActionWait.new(time, with_range, self)


# Creating Custom Actions
func perform(selector: String, on_target: Node, args: Array = []) -> GDAction:
	return GDActionPerform.new(selector, args, on_target, self)


func custom_action(selector: String, on_target: Node, duration: float) -> GDAction:
	return GDActionCustomAction.new(selector, on_target, duration, self)


func run(action: GDAction, on_target: Node, is_waiting_finished: bool = true) -> GDAction:
	return GDActionRun.new(action, on_target, is_waiting_finished, self)


# Controlling Node Visibility
# Control a node's visibility.
func hide() -> GDAction:
	return GDActionVisibility.new(true, self)


func unhide() -> GDAction:
	return GDActionVisibility.new(false, self)



# Manager Action

func pause_all_action():
	_cache.pause_all_action()

func pause_all_action_on_node(node: Node):
	_cache.pause_all_action_on_node(node)

func pause_action_on_node(node: Node, action: GDAction):
	_cache.pause_action_on_node(node, action)


func resume_all_action():
	_cache.resume_all_action()

func resume_all_action_on_node(node: Node):
	_cache.resume_all_action_on_node(node)

func resume_action_on_node(node: Node, action: GDAction):
	_cache.resume_action_on_node(node, action)


func cancel_all_action():
	_cache.cancel_all_action()

func cancel_all_action_on_node(node: Node):
	_cache.cancel_all_action_on_node(node)

func cancel_action_on_node(node: Node, action: GDAction):
	_cache.cancel_action_on_node(node, action)


func finish_all_action():
	_cache.finish_all_action()

func finish_all_action_on_node(node: Node):
	_cache.finish_all_action_on_node(node)

func finish_action_on_node(node: Node, action: GDAction):
	_cache.finish_action_on_node(node, action)

