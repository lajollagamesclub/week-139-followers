extends Sprite

const player_state = preload("res://player_state.tres")

func _on_player_moved(move_vector: Vector2):
	position.y += move_vector.y + 1.5*4.0

func _ready():
	randomize()
	player_state.connect("moved", self, "_on_player_moved")
	rotation_degrees = rand_range(-10.0, 10.0)
	var rand_scale: float = rand_range(3.5, 5.5)
	scale.x = rand_scale
	scale.y = rand_scale

func _process(delta):
	if position.y >= 1500.0:
		queue_free()
