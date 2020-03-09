extends Area2D

signal misstakedown
signal bag_of_rocks

var caught_something := false

func _ready():
	$CollisionShape2D.disabled = true

func takedown(on_left_side: bool):
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
		emit_signal("misstakedown")


func _on_SuitcaseTakedown_area_entered(area: Node2D):
	if area.is_in_group("suitcases"):
		caught_something = true
		if not area.if_takedownable_takedown():
			emit_signal("bag_of_rocks")
