extends Label

const player_state = preload("res://player_state.tres")

func _process(delta):
	text = str("Ammo: ", player_state.ammo)
