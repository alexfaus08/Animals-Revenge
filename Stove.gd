extends Area2D
var player_near 

func _ready():
	$StoveSprite.play("Idle")
	
func _process(delta):
	if(player_near):
		if(Input.is_action_just_pressed("ui_select")):
			$StoveSprite.play("Cooking")

func _on_Stove_body_entered(body):
	if(body.get_name() == "Player"):
		player_near = true
		
	


func _on_Stove_body_exited(body):
	if(body.get_name() == "Player"):
		player_near = false
