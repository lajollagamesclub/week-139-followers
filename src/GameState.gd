extends Node

signal caught

const player_state = preload("res://player_state.tres")

var caught := false

func reset(): # set default parameters
	caught = false
	player_state.reset()

func caught():
	caught = true
	emit_signal("caught")

func _input(event):
	if not caught:
		return
	if event is InputEventKey or event is InputEventMouseButton:
		get_tree().reload_current_scene()
		reset()
