extends Node2D

class_name TrainCar

const player_state = preload("res://player_state.tres")
const suitcase_offset = 300.0
const max_suitcase_len = 100.0 # don't go off top of train

var length: float = 1200.0 

func _ready():
	randomize()
	player_state.connect("moved", self, "_player_moved")
	update_visible_length()
	
	# spawn suitcases
	spawn_suitcases(-suitcase_offset)
	spawn_suitcases(suitcase_offset)

func spawn_suitcases(x_offset: float) -> void:
	var cur_y_pos: float = length - 100.0
	var cur_suitcase: Suitcase = preload("res://Suitcase.tscn").instance()
	var last_filled_with_rocks: bool = false
	while cur_y_pos > cur_suitcase.length + 50.0:
		if rand_range(0.0, 1.0) < 0.1: # spawn gun
			cur_y_pos += cur_suitcase.length - 100.0
			var cur_gun: Node2D = preload("res://GunPickup.tscn").instance()
			add_child(cur_gun)
			cur_gun.position = Vector2(x_offset - sign(x_offset)*50.0, cur_y_pos)
			cur_y_pos -= 200.0
			continue
		add_child(cur_suitcase)
		
		# make filled with rocks, ensuring no repeats
		if not last_filled_with_rocks and rand_range(0.0, 1.0) < 0.3:
			cur_suitcase.filled_with_rocks = true
			cur_suitcase.update_sprite()
			last_filled_with_rocks = true
		else:
			last_filled_with_rocks = false

		cur_suitcase.position = Vector2(x_offset, cur_y_pos)
		cur_y_pos -= rand_range(cur_suitcase.length + 30.0, cur_suitcase.length + 200.0)
		cur_suitcase = preload("res://Suitcase.tscn").instance()
	cur_suitcase.free() # loop will quit with an unused node

func update_visible_length():
	$ColorRect.rect_size.y = length
	$ColorRect.update()
	$LaneSeparators.length = length

func _player_moved(move_vector: Vector2) -> void:
	global_position += move_vector
	if global_position.y >= 3000.0:
		queue_free()
