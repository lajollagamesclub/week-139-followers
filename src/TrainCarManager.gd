extends Node2D

const traincar_gap = 50.0

onready var cur_traincar: TrainCar = $TrainCar

func _process(delta):
	var last_traincar_name = cur_traincar.name
	while cur_traincar.global_position.y > -1000.0:
		var last_traincar: TrainCar = cur_traincar
		
		cur_traincar = preload("res://TrainCar.tscn").instance()
		add_child(cur_traincar)
		cur_traincar.length = rand_range(800.0, 4100.0)
		cur_traincar.base_position.y = last_traincar.position.y - cur_traincar.length - traincar_gap
		cur_traincar.base_position.x = cur_traincar.position.x
		cur_traincar.global_position = cur_traincar.base_position
		
		cur_traincar.apply_stuff()
