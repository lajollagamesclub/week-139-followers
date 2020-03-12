extends Label

const player_state = preload("res://player_state.tres")

func _process(delta):
	visible = player_state.has_gun
	text = str("Ammo: ", player_state.ammo)
