extends Node

export (String) var sound_effect_folder_name

func _ready():
	randomize()

func play_random():
	self.call("play")
# this whole chunk of code is broken on web for some reason
#	var dir := Directory.new()
#
#	dir.open(str("res://sfx/", sound_effect_folder_name, "/"))
#	dir.list_dir_begin()
#
#	var filepaths: Array = []
#
#	while true:
#		var cur_filename: String = dir.get_next()
#		if cur_filename == "":
#			break
#		if not dir.current_is_dir() and cur_filename.ends_with(".wav"):
#			filepaths.append(str("res://sfx/", sound_effect_folder_name, "/", cur_filename))
#
#	var to_play: String = filepaths[randi() % filepaths.size()]
#	self.stream = load(to_play)
#	self.call("play")
