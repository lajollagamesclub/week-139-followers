extends Area2D

const player_state = preload("res://player_state.tres")

func interact() -> float:
	player_state.has_gun = true
	player_state.ammo += 8
	return 0.8
