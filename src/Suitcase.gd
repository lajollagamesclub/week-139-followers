extends Area2D

class_name Suitcase

const score_info_state = preload("res://score_info_state.tres")

var length: float = 200.0

var taken_down := false
var filled_with_rocks := false

func _ready():
	randomize()
#	filled_with_rocks = rand_range(0.0, 1.0) < 0.3

func update_sprite():
	if filled_with_rocks:
		$Sprite.modulate = Color("#00f9ff")
		$DropPlayer.sound_effect_folder_name = "bag-of-rocks"
		$DropPlayer.stream = preload("res://sfx/bag-of-rocks/3.wav")

func interact() -> float: # returns new slowdown percentage
	if taken_down:
		return 1.0
	if filled_with_rocks:
		$DropPlayer.play_random()
		score_info_state.add_score(global_position, -300)
		return 0.3
	taken_down = true
	score_info_state.add_score(global_position, 100)
	$DropPlayer.play_random()
	$TakedownTween.interpolate_property(self, "position", position, Vector2(position.x + (2.0*float(Player.on_left_side(global_position.x)) - 1.0)*Player.step + rand_range(-40.0, 40.0), position.y), rand_range(0.3, 0.7), Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$TakedownTween.start()
	$RotationTween.interpolate_property(self, "rotation_degrees", rotation_degrees, rotation_degrees + rand_range(-90, 90.0), rand_range(0.3, 0.6), Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$RotationTween.start()
	return 0.75
