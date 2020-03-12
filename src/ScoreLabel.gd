extends Label

func _process(delta):
	text = str("Score: ", GameState.score)
