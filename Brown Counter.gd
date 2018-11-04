extends Area2D

var player_near_counter
func _ready():
	player_near_counter = false
	

func _process(delta):
	if(player_near_counter):
		if(Input.is_action_just_pressed("ui_select")):
			print("open")

func _on_Fridge_body_entered(body):
	if (body.get_name() == "Player"):
		player_near_fridge = true


func _on_Fridge_body_exited(body):
	if (body.get_name() == "Player"):
		player_near_fridge = false
