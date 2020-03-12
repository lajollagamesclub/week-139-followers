extends Node2D

const score_info_state = preload("res://score_info_state.tres")

func _ready():
	score_info_state.connect("new_score", self, "_on_new_score")

func _on_new_score(global_pos: Vector2, new_score: int):
	var cur_info_text: Node2D = preload("res://ScoreInfoText.tscn").instance()
	add_child(cur_info_text)
	cur_info_text.new_score = new_score
	cur_info_text.global_position = global_pos
	cur_info_text.apply_text()
