extends Label

func _ready():
	if GameState.tutorial_mode:
		visible = false

func _process(delta):
	text = str("Score: ", GameState.score)
