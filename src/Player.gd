extends Area2D

const player_state = preload("res://player_state.tres")
const middle = 960.0
const step = 200.0


onready var target_x_pos: float = global_position.x

var target_speed := 700.0
var cur_speed := 0.0

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
	if cur_speed < 0.40*target_speed: # can only takedown when at speed
		return
	cur_speed = target_speed*0.3
	$SuitcaseTakedown.takedown(on_left_side())

func _physics_process(delta):
	global_position.x = ((target_x_pos - global_position.x) * 25.0 * delta) + global_position.x
	
	cur_speed = ((target_speed - cur_speed) * 2.5 * delta) + cur_speed
	
	player_state.move(Vector2(0, -cur_speed)*delta)

func on_left_side() -> bool:
	return target_x_pos < middle
