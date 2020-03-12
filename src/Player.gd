extends Area2D

class_name Player

const player_state = preload("res://player_state.tres")
const middle = 960.0
const step = 200.0


onready var target_x_pos: float = global_position.x

var cur_speed := 0.0
onready var original_y := global_position.y

func _ready():
	GameState.connect("caught", self, "_on_caught")
	cur_speed = player_state.target_speed
	$Gun.excluding.append(self)

func _on_caught():
	set_process_input(false)
	player_state.target_speed = 0.0
	$AnimatedSprite.stop()

func _input(event):
	if event.is_action_pressed("g_left"):
		if on_left_side(target_x_pos):
			take_down_suitcase()
		else:
			target_x_pos -= step
	elif event.is_action_pressed("g_right"):
		if not on_left_side(target_x_pos):
			take_down_suitcase()
		else:
			target_x_pos += step
	elif event.is_action_pressed("g_takedown"):
		take_down_suitcase()
	elif player_state.has_gun and player_state.ammo > 0 and event.is_action_pressed("g_shoot"):
		$Gun.shoot(get_global_mouse_position())

func hit():
	cur_speed = 0.5*cur_speed
	print("ouch")

func take_down_suitcase():
	if cur_speed < 0.40*player_state.target_speed: # can only takedown when at speed
		return
#	cur_speed = player_state.target_speed*0.65
	$SuitcaseTakedown.interact(on_left_side(target_x_pos))

func _physics_process(delta):
	var movement_offset: Vector2 = Vector2()
	if not GameState.caught:
		player_state.target_speed = 700.0 + GameState.g_time*5.0
	
#	if player_state.cur_traincar != null:
#		movement_offset = player_state.cur_traincar.movement_offset
	
	global_position.x = ((target_x_pos - global_position.x) * 25.0 * delta) + global_position.x
	global_position.x += movement_offset.x
	global_position.y = original_y + movement_offset.y
	
	var smoothing: float = 0.8
	if GameState.caught:
		smoothing = 15.0
	cur_speed = ((player_state.target_speed - cur_speed) * smoothing * delta) + cur_speed
	
	player_state.y_offset = global_position.y
	player_state.move(Vector2(0, -cur_speed)*delta)
	player_state.x_offset = global_position.x

static func on_left_side(x_pos: float) -> bool:
	return x_pos < middle


func _on_SuitcaseTakedown_takedown_slowdown(new_speed_fraction: float):
	print(new_speed_fraction)
	cur_speed = player_state.target_speed*new_speed_fraction
