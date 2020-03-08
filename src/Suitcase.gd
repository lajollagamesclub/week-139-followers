extends Area2D

class_name Suitcase

var length: float = 200.0

var taken_down: bool = false

func _ready():
	randomize()

func takedown():
	if taken_down:
		return
	taken_down = true
	$TakedownTween.interpolate_property(self, "position", position, Vector2(position.x + (2.0*float(Player.on_left_side(global_position.x)) - 1.0)*Player.step + rand_range(-40.0, 40.0), position.y), rand_range(0.3, 0.7), Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$TakedownTween.start()
	$RotationTween.interpolate_property(self, "rotation_degrees", rotation_degrees, rotation_degrees + rand_range(-90, 90.0), rand_range(0.3, 0.6), Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$RotationTween.start()
