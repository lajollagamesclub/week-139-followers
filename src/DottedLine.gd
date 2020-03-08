tool
extends Node2D

const player_state = preload("res://player_state.tres")

export var line_length: float = 40.0
export var gap_length: float = 20.0
export var width: float = 4.0
export var color := Color()

var offset := 0.0

func _process(delta):
	if not Engine.editor_hint:
		offset = player_state.pos.y
	update()

func _draw():
	var cur_line_y: float = fmod(offset, line_length + gap_length) - (line_length + gap_length)
	while cur_line_y < 1080.0:
		draw_line(Vector2(0, cur_line_y), Vector2(0, cur_line_y + line_length), color, width)
		cur_line_y += line_length + gap_length
