extends Node2D

onready var label = $UI2/Tutorialtext

func _ready():
	if not GameState.tutorial_mode:
		label.visible = false
		return
	label.text = "Agent - You've been compromised!"
	yield(get_tree().create_timer(6.0), "timeout")
	label.text = "Use A and D to move back and forth"
	yield(get_tree().create_timer(6.0), "timeout")
	label.text = "Use the same keys to interact with the luggage on the train by pressing the key again while already on a side"
	yield(get_tree().create_timer(7.0), "timeout")
	label.text = "Slow him down before he can catch you! Avoid the bags filled with rocks"
	GameState.guy_going_fast = true
	yield(get_tree().create_timer(10.0), "timeout")
	label.text = "We're sending you some firepower - they may attract more powerful enemies! Use left click and aim with mouse to shoot"
	GameState.spawning_guns = true
	GameState.tutorial_mode = false
	yield(get_tree().create_timer(10.0), "timeout")
	label.text = ""
	
func _process(delta):
	if not GameState.tutorial_mode:
		return
	label.visible = not GameState.caught
