extends Node

signal caught

const player_state = preload("res://player_state.tres")

var caught := false
var score := 0
var g_time := 0.0
var tutorial_mode := true setget set_tutorial_mode
var spawning_guns := false
var guy_going_fast := false

func _process(delta):
	g_time += delta

func set_tutorial_mode(new_tutorial_mode):
	tutorial_mode = new_tutorial_mode
	if not tutorial_mode:
		spawning_guns = true
		guy_going_fast = true

func reset(): # set default parameters
	caught = false
	score = 0
	g_time = 0.0
	player_state.reset()

func caught():
	caught = true
	emit_signal("caught")

func reload():
	reset()
	get_tree().reload_current_scene()

func _input(event):
	if not caught:
		return
	if event is InputEventKey and event.scancode == KEY_SPACE:
		reload()
