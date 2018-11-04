extends Area2D
var player_near 
var stove_off
onready var t = get_node("../Timer")

func _ready():
	stove_off = true
	$StoveSprite.play("Idle")
	
func _process(delta):
	if(player_near and stove_off):
		if(Input.is_action_just_pressed("ui_select")):
			stove_off = false
			$StoveSprite.play("Cooking")
			# wait 5 seconds
			t.set_wait_time(5)
			t.start()
			yield(t, "timeout")
			$StoveSprite.play("On")
			t.set_wait_time(3)
			t.start()
			yield(t, "timeout")
			$StoveSprite.play("Idle")
			stove_off = true

func _on_Stove_body_entered(body):
	if(body.get_name() == "Player"):
		player_near = true
		
	


func _on_Stove_body_exited(body):
	if(body.get_name() == "Player"):
		player_near = false
