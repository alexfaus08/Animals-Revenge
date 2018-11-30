extends Control
onready var game_timer = $"Game Timer"
onready var score_label = $"ScoreNum"
onready var time_left_label = $"TimerLabel"
var score = 0

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _process(delta):
	time_left_label.set_text(str(int(game_timer.get_time_left())))
	if(game_timer.get_time_left() == 0.0):
		$"../Game Over".game_over()

func updatescore(new_score):
	score += new_score
	score_label.set_text(str(score))

func get_score():
	return score
	