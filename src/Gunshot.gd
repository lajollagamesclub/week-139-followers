extends Node2D

const player_state = preload("res://player_state.tres")

var target_group: String = "hittable"
var excluding: Array = []

func _ready():
	player_state.connect("moved", self, "_on_player_moved")

func _on_player_moved(move_vector: Vector2):
	global_position += move_vector


func _physics_process(delta):
	if $RayCast2D.is_colliding():
		var collider: Node2D = $RayCast2D.get_collider()
		if collider == null:
			return
		if collider in excluding:
			return
		$Trail.max_length = $RayCast2D.get_collision_point().distance_to(global_position)
		if collider.is_in_group(target_group):
			collider.hit()
			$RayCast2D.enabled = false
	modulate.a -= delta*2.0
	if modulate.a <= 0.0:
		free()
		return
	if global_position.y >= 3000.0:
		free()
		return
