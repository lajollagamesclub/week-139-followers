extends Node2D

const traincar_gap = 50.0

onready var cur_traincar: TrainCar = $TrainCar

func _process(delta):
	while cur_traincar.global_position.y > -1000.0:
		var last_traincar: TrainCar = cur_traincar
		cur_traincar = preload("res://TrainCar.tscn").instance()
		cur_traincar.length = rand_range(800.0, 4100.0)
		cur_traincar.global_position = last_traincar.global_position - Vector2(0, cur_traincar.length + traincar_gap)
		add_child(cur_traincar)
