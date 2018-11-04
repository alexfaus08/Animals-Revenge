extends Area2D

var player_near_fridge
func _ready():
	player_near_fridge = false
	pass

func _process(delta):
	if(player_near_fridge):
		if(Input.is_action_just_pressed("ui_select")):
			print("open")

func _on_Fridge_body_entered(body):
	if (body.get_name() == "Player"):
		player_near_fridge = true
