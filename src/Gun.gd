extends Node2D

const player_state = preload("res://player_state.tres")

func _input(event):
	if player_state.has_gun and player_state.ammo > 0 and event.is_action_pressed("g_shoot"):
		$GunshotSoundEffect.play_random()
		var cur_gunshot: Node2D = preload("res://Gunshot.tscn").instance()
		get_node("/root/Main/Gunshots").add_child(cur_gunshot)
		cur_gunshot.global_transform = global_transform
		cur_gunshot.rotation = global_position.angle_to_point(get_global_mouse_position()) + PI
