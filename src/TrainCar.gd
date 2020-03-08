extends Node2D

class_name TrainCar

const player_state = preload("res://player_state.tres")

var length: float = 1200.0 

func _ready():
	player_state.connect("moved", self, "_player_moved")
	update_visible_length()

func update_visible_length():
	$ColorRect.rect_size.y = length
	$ColorRect.update()
	$LaneSeparators.length = length

func _player_moved(move_vector: Vector2) -> void:
	global_position += move_vector
	if global_position.y >= 3000.0:
		queue_free()
