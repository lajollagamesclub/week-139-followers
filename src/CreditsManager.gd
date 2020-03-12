extends Node2D

var credits: Array = [
	"A game by La Jolla Games Club",
	"Cameron Reikes - Game Lead, Programmer",
	"Zhiyi Lin - Art Lead",
	"SassyKeys - Music",
	"Matthias Fluor - Sound Effects",
	"Made for Weekly Game Jam 139 in one week"
]

func _ready():
	randomize()

func _on_SpawnTimer_timeout():
	if credits.size() == 0:
		$SpawnTimer.stop()
		return
	var on_left: int = randi()%2
	var x_offset: float = 281.0
	if on_left == 1:
		x_offset = 1920.0 - 281.0
	
	var cur_credits_text: String = credits.pop_front()
	var cur_credits: Label = preload("res://CreditsLabel.tscn").instance()
	add_child(cur_credits)
	cur_credits.text = cur_credits_text
	cur_credits.rect_position = Vector2(x_offset, -200.0)
	cur_credits.update_looks()
