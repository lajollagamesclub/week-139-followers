extends Node2D

class_name TrainCar

const player_state = preload("res://player_state.tres")
const suitcase_offset = 300.0
const max_suitcase_len = 100.0 # don't go off top of train

export var apply_own_stuff := false

var length: float = 1200.0 

var movement_offset: Vector2 = Vector2()
var base_position: Vector2 = Vector2()
var time: float = 0.0
var r_time_scale: Vector2 = Vector2()
var already_said_i_control_player := false

func _ready():
	randomize()
	r_time_scale.x = rand_range(0.7, 1.4)
	r_time_scale.y = rand_range(0.9, 1.6)
	if apply_own_stuff:
		base_position = position
		apply_stuff()

func apply_stuff():
	time = rand_range(0.0, 200.0)
	player_state.connect("moved", self, "_player_moved")
	update_visible_length()
	
	# spawn suitcases
	spawn_suitcases(-suitcase_offset)
	spawn_suitcases(suitcase_offset)
	
#	base_position = global_position

func spawn_suitcases(x_offset: float) -> void:
	var cur_y_pos: float = length - 200.0
	var cur_suitcase: Suitcase = preload("res://Suitcase.tscn").instance()
	var last_filled_with_rocks: bool = false
	while cur_y_pos > cur_suitcase.length + 100.0:
		if rand_range(0.0, 1.0) < 0.1 and GameState.spawning_guns: # spawn gun
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

func _process(delta):
	time += delta*2.0
	movement_offset = Vector2(
		sin(time*r_time_scale.x),
		cos(time*r_time_scale.y)
	)*15.0
	position = base_position + movement_offset
	if position.y >= 0.0 and not already_said_i_control_player:
		player_state.cur_traincar = self
		already_said_i_control_player = true

func update_visible_length():
	$ColorRect.rect_size.y = length
	$Front.position.y = length
	$ColorRect.update()
	$MiddleSprite.region_rect.size.y = length/4.0
	$LaneSeparators.length = length

func _player_moved(move_vector: Vector2) -> void:
	base_position += move_vector
	if base_position.y >= 7000.0:
		if player_state.cur_traincar == self: # should never happen
			printerr("No traincar replaced me!")
			player_state.cur_traincar = null 
		queue_free()
	
