extends Resource

signal new_score(pos, score)

func add_score(global_pos: Vector2, new_score: int):
	emit_signal("new_score", global_pos, new_score)
