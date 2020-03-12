extends Area2D

const player_state = preload("res://player_state.tres")
const score_info_state = preload("res://score_info_state.tres")

func _ready():
	randomize()
	rotation = rand_range(0.0, 2.0*PI)

func interact() -> float:
	player_state.has_gun = true
	score_info_state.add_score(global_position, 250)
	player_state.ammo += 8
	visible = false
	$PickupSoundEffect.play()
	return 0.5
