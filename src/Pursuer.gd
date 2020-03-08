extends Area2D

const player_state = preload("res://player_state.tres")

var target_speed: float = 0.0
var cur_speed: float = 0.0

func _ready():
	player_state.connect("moved", self, "_on_player_moved")

func _physics_process(delta):
	target_speed = -player_state.target_speed*1.05
	
	cur_speed = ((target_speed - cur_speed) * 1.1 * delta) + cur_speed
	
	global_position += Vector2(0.0, cur_speed)*delta
	global_position.x = ((player_state.x_offset - global_position.x) * 4.0 *delta) + global_position.x

func _on_player_moved(move_vector):
	global_position += move_vector
