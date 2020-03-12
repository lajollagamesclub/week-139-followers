extends Area2D

const player_state = preload("res://player_state.tres")

func _ready():
	randomize()
	rotation = rand_range(0.0, 2.0*PI)

func interact() -> float:
	player_state.has_gun = true
	player_state.ammo += 8
	visible = false
	return 0.5
