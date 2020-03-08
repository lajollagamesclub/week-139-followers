extends Resource

signal moved(move_vector)

var pos: Vector2 = Vector2()

func move(move_vector: Vector2):
	emit_signal("moved", -move_vector)
	pos -= move_vector
