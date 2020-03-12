extends Area2D

signal dead(what_my_spot_was)

const player_state = preload("res://player_state.tres")
const score_info_state = preload("res://score_info_state.tres")

var target_spot: Vector2 = Vector2() setget set_target_spot

var my_spot: Vector2 = Vector2()

var real_pos: Vector2 = Vector2()
var time := 0.0
var health := 0
var dying := false

var target_rotation: float = 0.0

func _ready():
	randomize()
	time += rand_range(0.0, 200.0)
	health = randi()%3 + 1
	$SpatialGun.excluding.append(self)
	$SpatialGun.target_group = "player"

func _physics_process(delta):
	time += delta
	var offset := Vector2(
		cos(time + sin(time)*2.0),
		sin(time*0.3*3.0 + sin(time/3.0) + time*0.1)*5.0
	)*30.0
	
	real_pos = lerp(real_pos, target_spot, 0.05)
	global_position = real_pos + offset
	rotation = lerp(rotation, target_rotation, deg2rad(5.0))

func set_target_spot(new_target_spot):
	target_spot = new_target_spot
	

func hit():
	if dying:
		return
	health -= 1
	rotation = deg2rad((2.0*float(randi()%2) - 1.0)*30.0)
	
	if health <= 0:
		if target_spot.x < 1080.0/2.0:
			target_spot.x -= 500.0
			target_rotation -= deg2rad(70.0)
		else:
			target_spot.x += 500.0
			target_rotation += deg2rad(70.0)
		score_info_state.add_score(global_position, 500)
		$RevAway.play()
		$DeathTimer.start()
		dying = true
	else:
		score_info_state.add_score(global_position, 50)


func _on_DeathTimer_timeout():
	$CollisionShape2D.disabled = true
	emit_signal("dead", my_spot)
	$DeathTimer.stop()
	$ShootTimer.stop()
	$EngineAmbience.stop()
#	call_deferred("free")


func _on_ShootTimer_timeout():
	if $CollisionShape2D.disabled:
		return
	$SpatialGun.shoot(Vector2(player_state.x_offset, player_state.y_offset - 200.0))
	$ShootTimer.start()
