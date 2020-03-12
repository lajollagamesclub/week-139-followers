extends Node2D

var new_score := 100

func _ready():
	apply_text()

func _process(delta):
	modulate.a -= delta
	position.y -= 50.0*delta
	if modulate.a <= 0.0:
		queue_free()

func apply_text():
	GameState.score += new_score
	$Label.text = str(new_score)
	$Label.rect_position = -$Label.rect_size/2.0
	if new_score < 0:
		modulate.g = 0.0
		modulate.b = 0.0
