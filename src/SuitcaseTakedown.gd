extends Area2D

func _ready():
	$CollisionShape2D.disabled = true

func takedown(on_left_side: bool):
	if on_left_side:
		position.x = -$CollisionShape2D.shape.extents.x
	else:
		position.x = $CollisionShape2D.shape.extents.x
	$CollisionShape2D.disabled = false
	$Timer.start()

func _on_Timer_timeout():
	$CollisionShape2D.disabled = true


func _on_SuitcaseTakedown_area_entered(area: Node2D):
	if area.is_in_group("suitcases"):
		area.takedown()
