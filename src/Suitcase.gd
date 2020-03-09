extends Area2D

class_name Suitcase

var length: float = 200.0

var taken_down := false
var filled_with_rocks := false

func _ready():
	randomize()
	
#	filled_with_rocks = rand_range(0.0, 1.0) < 0.3
	
	

func update_sprite():
	if filled_with_rocks:
		$Sprite.modulate = Color("#00f9ff")

func if_takedownable_takedown() -> bool: # returns if successful
	if taken_down:
		return true
	if filled_with_rocks:
		return false
	taken_down = true
	$TakedownTween.interpolate_property(self, "position", position, Vector2(position.x + (2.0*float(Player.on_left_side(global_position.x)) - 1.0)*Player.step + rand_range(-40.0, 40.0), position.y), rand_range(0.3, 0.7), Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$TakedownTween.start()
	$RotationTween.interpolate_property(self, "rotation_degrees", rotation_degrees, rotation_degrees + rand_range(-90, 90.0), rand_range(0.3, 0.6), Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$RotationTween.start()
	return true
