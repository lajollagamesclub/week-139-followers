extends Node2D

const player_state = preload("res://player_state.tres")

var target_group: String = "hittable"
var excluding: Array = []

func shoot(target_position: Vector2):
	$GunshotSoundEffect.play_random()
	var cur_gunshot: Node2D = preload("res://Gunshot.tscn").instance()
	get_node("/root/Main/Gunshots").add_child(cur_gunshot)
	cur_gunshot.global_transform = global_transform
	cur_gunshot.target_group = target_group
	cur_gunshot.excluding = excluding
	cur_gunshot.rotation = global_position.angle_to_point(target_position) + PI
