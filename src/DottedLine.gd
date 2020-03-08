tool
extends Node2D

const player_state = preload("res://player_state.tres")

export var line_length: float = 40.0
export var gap_length: float = 20.0
export var total_length := 120.0 # for preview in editor only
export var width: float = 4.0
export var color := Color()

var offset := 0.0
var real_total_length: float = 0.0

func _ready():
	set_process(Engine.editor_hint)

func _process(delta):
	real_total_length = total_length * 10.0
#	if not Engine.editor_hint:
#		offset = player_state.pos.y
	update()

func _draw():
#	var cur_line_y: float = fmod(offset, line_length + gap_length) - (line_length + gap_length)
	var cur_line_y: float = 0.0
	while cur_line_y < real_total_length:
		var new_line_y: float = cur_line_y + min(line_length, real_total_length - cur_line_y)
		draw_line(Vector2(0, cur_line_y), Vector2(0, new_line_y), color, width)
		cur_line_y += line_length + gap_length
