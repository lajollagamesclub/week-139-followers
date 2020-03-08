extends Area2D

const player_state = preload("res://player_state.tres")


func _physics_process(delta):
	player_state.move(Vector2(0, -500)*delta)
