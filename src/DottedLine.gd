tool
extends Node2D

export var line_length: float = 40.0
export var gap_length: float = 20.0
export var width: float = 4.0
export var color: Color = Color()

func _process(delta):
	update()

func _draw():
	var cur_line_y: float = 0.0
	while cur_line_y < 1080.0:
		draw_line(Vector2(0, cur_line_y), Vector2(0, cur_line_y + line_length), color, width)
		cur_line_y += line_length + gap_length
