extends Resource

signal moved(move_vector)

var pos: Vector2 = Vector2()
var x_offset: float = 0.0
var target_speed := 700.0

func move(move_vector: Vector2):
	emit_signal("moved", -move_vector)
	pos -= move_vector
