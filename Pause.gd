extends Control

func _ready():
	hide()
	
func _process(delta):
	if (get_tree().paused):
		if (Input.is_action_just_pressed("quit")):
			get_tree().quit()

func _input(event):
	# pauses all proccesses
	# the following code was copied from this 
	# YouTube video: https://www.youtube.com/watch?v=Jf7F3JhY9Fg
	if (event.is_action_pressed("pause")):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state 
		
