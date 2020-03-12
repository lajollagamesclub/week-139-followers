extends Node

signal caught

const player_state = preload("res://player_state.tres")

var caught := false
var score := 0
var g_time := 0.0

func _process(delta):
	g_time += delta

func reset(): # set default parameters
	caught = false
	score = 0
	g_time = 0.0
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
