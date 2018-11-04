extends Control

func _ready():
	hide()

func _input(event):
	# pauses all proccesses
	if (event.is_action_pressed("pause")):
		print("Pause")
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state 
