extends Node2D

export var max_length := 2500.0

var cur_length: float = 0.0

func _process(delta):
	cur_length += delta*2500.0*(1.0/0.2)
	update()
	if cur_length >= max_length:
		cur_length = max_length
	

func _draw():
	draw_line(Vector2(), Vector2(cur_length, 0.0), Color(1, 1, 1), 4.0, false)
