extends Node2D

func _ready():
	randomize()

func _on_SpawnTimer_timeout():
	var cur_shrub: Node2D = preload("res://Shrub.tscn").instance()
	
	add_child(cur_shrub)
	cur_shrub.global_position = Vector2(rand_range(0.0, 1920.0), -100.0)
	
	$SpawnTimer.wait_time = rand_range(0.1, 0.3)
	$SpawnTimer.start()
