extends Node2D

var length: float = 1200.0 setget set_length

func set_length(new_length):
	length = new_length
	for separator in [$MiddleLine, $RightLine, $LeftLane]:
		separator.real_total_length = length
		separator.update()
