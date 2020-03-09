extends Area2D

const player_state = preload("res://player_state.tres")

var target_speed: float = 0.0
var target_x_pos: float = 0.0
var cur_speed: float = 0.0
var on_left_side: float = 0.0

func _ready():
	player_state.connect("moved", self, "_on_player_moved")

func _physics_process(delta):
#	print(player_state.y_offset, "	", global_position.y)
	if player_state.y_offset >= global_position.y:
		target_speed = -player_state.target_speed*0.5
	else:
		target_speed = -player_state.target_speed*1.35

	if abs(player_state.y_offset - global_position.y) < 100.0:
		target_x_pos = player_state.x_offset
	else:
		target_x_pos = (Player.middle - Player.step/2.0) + on_left_side*Player.step
	
	cur_speed = ((target_speed - cur_speed) * 0.9 * delta) + cur_speed
	
	global_position += Vector2(0.0, cur_speed)*delta
	global_position.x = ((target_x_pos - global_position.x) * 4.0 *delta) + global_position.x

func _on_player_moved(move_vector):
	global_position += move_vector


func _on_Pursuer_area_entered(area):
	if area.is_in_group("suitcases") and area.taken_down:
		if global_position.y > 1200.0: # don't go super far down if down
			return
		var random_number: float = rand_range(0.0, 1.0)
		if random_number >= 0.3:
			on_left_side = 1.0 - on_left_side
		cur_speed = 0.30*target_speed
