extends Node2D

const player_state = preload("res://player_state.tres")

func _ready():
	player_state.connect("moved", self, "_on_player_moved")

func _on_player_moved(move_vector: Vector2):
	global_position += move_vector


func _process(delta):
	if $RayCast2D.is_colliding():
		$Trail.max_length = $RayCast2D.get_collision_point().distance_to(global_position)
	modulate.a -= delta*0.5
	if modulate.a <= 0.0:
		queue_free()
	if global_position.y >= 3000.0:
		queue_free()
