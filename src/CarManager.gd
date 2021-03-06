extends Node2D

const horizontal_margin := 281.0
const vertical_margin := 270.0
const player_state = preload("res://player_state.tres")
#const vertical_spacing := 540.0

var available_car_spots = []

func _ready():
	randomize()
	
	available_car_spots.append(Vector2(horizontal_margin, vertical_margin))
	available_car_spots.append(Vector2(horizontal_margin, 1080.0 - vertical_margin))
	available_car_spots.append(Vector2(1920.0 - horizontal_margin, vertical_margin))
	available_car_spots.append(Vector2(1920.0 - horizontal_margin, 1080.0 - vertical_margin))


func _on_SpawnCarTimer_timeout():
	if available_car_spots.size() <= 0 or not player_state.has_gun or GameState.caught:
		_new_timer_time()
		return
	
	var car_spot_index: int = randi()%available_car_spots.size()
	var cur_car_spot: Vector2 = available_car_spots[car_spot_index]
	available_car_spots.remove(car_spot_index)
	
	var cur_car: Node2D = preload("res://Car.tscn").instance()
	add_child(cur_car)
	cur_car.target_spot = cur_car_spot
	cur_car.my_spot = cur_car_spot
	
	if cur_car_spot.x < 1080.0/2.0:
		cur_car_spot.x -= horizontal_margin*2.0
		cur_car.rotation = deg2rad(40.0)
	else:
		cur_car_spot.x += horizontal_margin*2.0
		cur_car.rotation = -deg2rad(40.0)
		
	cur_car.real_pos = cur_car_spot
	cur_car.global_position = cur_car_spot
	
	cur_car.connect("dead", self, "_on_car_death")
	
	_new_timer_time()

func _on_car_death(open_spot: Vector2):
	available_car_spots.append(open_spot)
	print(available_car_spots)

func _new_timer_time():
	$SpawnCarTimer.wait_time = rand_range(4.0, 10.0)*max(0.2, 1.0 - GameState.g_time/120.0)
	$SpawnCarTimer.start()
