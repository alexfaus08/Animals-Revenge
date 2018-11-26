extends Control
onready var game_timer = $"Game Timer"
onready var score = $"ScoreNum"
onready var time_left_label = $"TimerLabel"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _process(delta):
	time_left_label.set_text(str(int(game_timer.get_time_left())))
	if(game_timer.get_time_left() == 0.0):
		$"../Game Over".game_over()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
