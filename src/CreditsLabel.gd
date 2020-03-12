extends Label

const player_state = preload("res://player_state.tres")

func _on_player_moved(move_vector: Vector2):
	rect_position.y += move_vector.y*0.3 + 1.5*4.0

func _ready():
	player_state.connect("moved", self, "_on_player_moved")

func update_looks():
	rect_position -= rect_size/2.0

func _process(delta):
	if rect_position.y >= 1500.0:
		queue_free()
