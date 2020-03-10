extends Resource

signal moved(move_vector)

var pos: Vector2 = Vector2()
var x_offset: float = 0.0
var y_offset: float = 0.0
var target_speed := 700.0
var has_gun := false
var ammo := 0

func move(move_vector: Vector2):
	emit_signal("moved", -move_vector)
	pos -= move_vector

func reset():
	pos = Vector2()
	x_offset = 0.0
	y_offset = 0.0
	target_speed = 700.0
	has_gun = false
	ammo = 0
