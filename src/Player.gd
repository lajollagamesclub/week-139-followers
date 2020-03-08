extends Area2D

const player_state = preload("res://player_state.tres")
const middle = 960.0
const step = 200.0

onready var target_x_pos: float = global_position.x

func _input(event):
	if event.is_action_pressed("g_left"):
		if on_left_side():
			take_down_suitcase()
		else:
			target_x_pos -= step
	elif event.is_action_pressed("g_right"):
		if not on_left_side():
			take_down_suitcase()
		else:
			target_x_pos += step

func take_down_suitcase():
	pass

func _physics_process(delta):
	global_position.x = ((target_x_pos - global_position.x) * 15.0 * delta) + global_position.x
	
	player_state.move(Vector2(0, -500)*delta)

func on_left_side() -> bool:
	return target_x_pos < middle
