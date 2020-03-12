extends Area2D

const player_state = preload("res://player_state.tres")

var target_speed: float = 0.0
var target_x_pos: float = 0.0
var cur_speed: float = 0.0
var on_left_side: float = 0.0

var smoothing := 0.9
var last_target_speed := 0.0
var last_smoothing := smoothing
var coming_back_from_shot := false

func _ready():
#	GameState.connect("caught", self, "_on_player_caught")
	player_state.connect("moved", self, "_on_player_moved")

func _physics_process(delta):
#	print(player_state.y_offset, "	", global_position.y)
	if GameState.caught:
		target_speed = 0.0
	elif player_state.y_offset >= global_position.y:
		target_speed = -player_state.target_speed*0.5
	else:
		if GameState.guy_going_fast:
			target_speed = -player_state.target_speed*1.1
		else:
			if global_position.y > 950.0:
				target_speed = -player_state.target_speed*1.2
			else:
				target_speed = -player_state.target_speed*0.9

	if abs(player_state.y_offset - global_position.y) < 100.0:
		target_x_pos = player_state.x_offset
	else:
		target_x_pos = (Player.middle - Player.step/2.0) + on_left_side*Player.step
	
#	print(coming_back_from_shot, "	", abs(cur_speed - target_speed), "	", target_speed)
	if coming_back_from_shot and abs(cur_speed - target_speed) < abs(0.05*target_speed):
		coming_back_from_shot = false
		target_speed = last_target_speed
		smoothing = last_smoothing
	
	if not GameState.guy_going_fast:
		smoothing = 2.0
	
	if GameState.caught:
		smoothing = 15.0
	
	
	
	cur_speed = ((target_speed - cur_speed) * smoothing * delta) + cur_speed
	
	
	
	global_position += Vector2(0.0, cur_speed)*delta
	global_position.x = ((target_x_pos - global_position.x) * 4.0 *delta) + global_position.x

func hit():
	if coming_back_from_shot:
		cur_speed = -0.5*target_speed
		return
	last_target_speed = target_speed
	last_smoothing = smoothing
	target_speed = cur_speed
	cur_speed = -0.5*target_speed
	smoothing = 10.0
	coming_back_from_shot = true

func _on_player_moved(move_vector):
	global_position += move_vector


func _on_Pursuer_area_entered(area):
	if area.is_in_group("player"):
		GameState.caught()
		$AnimatedSprite2.stop()
	if area.is_in_group("suitcases") and area.taken_down:
		if global_position.y > 1200.0: # don't go super far down if down
			return
		var random_number: float = rand_range(0.0, 1.0)
		if random_number >= 0.3:
			on_left_side = 1.0 - on_left_side
			
		cur_speed = 0.1*target_speed
