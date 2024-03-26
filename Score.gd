extends Node

export var high_score : float = 0
export var current_score : float = 0

var score_per_second = 5
var game_in_progress = false

func start():
	current_score = 0
	game_in_progress = true
	
func end():
	game_in_progress = false
	if current_score > high_score:
		high_score = current_score

func add(score):
	if !game_in_progress:
		return
	current_score += score

func _process(delta):
	if !game_in_progress:
		return
		
	current_score += score_per_second * delta
	
