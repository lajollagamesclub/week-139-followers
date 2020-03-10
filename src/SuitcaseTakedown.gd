extends Area2D

signal takedown_slowdown(new_speed_fraction)

var caught_something := false

func _ready():
	$CollisionShape2D.disabled = true

func interact(on_left_side: bool):
	caught_something = false
	if on_left_side:
		position.x = -$CollisionShape2D.shape.extents.x
	else:
		position.x = $CollisionShape2D.shape.extents.x
	$CollisionShape2D.disabled = false
	$Timer.start()

func _on_Timer_timeout():
	$CollisionShape2D.disabled = true
	if not caught_something:
		emit_signal("takedown_slowdown", 0.3)


func _on_SuitcaseTakedown_area_entered(area: Node2D):
	if area.is_in_group("interactable"):
		caught_something = true
		emit_signal("takedown_slowdown", area.interact())
