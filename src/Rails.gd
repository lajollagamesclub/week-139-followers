extends Sprite

const player_state = preload("res://player_state.tres")

func _ready():
	player_state.connect("moved", self, "_on_player_moved")

func _on_player_moved(move_vector: Vector2):
	region_rect.position.y -= move_vector.y/4.0 + 1.5
