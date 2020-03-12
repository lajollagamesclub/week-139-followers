extends Button

func _ready():
	visible = GameState.tutorial_mode


func _on_SkipTutorialButton_pressed():
	GameState.tutorial_mode = false
	GameState.reload()
