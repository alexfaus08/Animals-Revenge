extends Area2D
var player_near_stove
var stove_off
onready var t = get_node("Stove Timer")

func _ready():
	# when the game starts the stove is off
	stove_off = true
	# when the game starts set the stove animation to idle
	$StoveSprite.play("Idle")
	
func _process(delta):
	# if the player is near the stove and the stove is off
	# this way that can't turn on the stove again if it's on
	if(player_near_stove and stove_off):
		# if the spacebar is pressed (see: project settings: input map)
		if(Input.is_action_just_pressed("ui_select")):
			# the stove is now on
			stove_off = false
			# play the cooking animation
			$StoveSprite.play("Cooking")
			# wait 5 seconds
			t.set_wait_time(5)
			# start the stove timer
			t.start()
			# wait until the timer completes it's wait time
			yield(t, "timeout")
			# cooking is over, go back to idle
			$StoveSprite.play("Idle")
			stove_off = true

# if any body has enter the collision area of the stove this signal fires
func _on_Stove_body_entered(body):
	# check to see if that body is the player 
	if(body.get_name() == "Player"):
		# set player near stove to true because they are intersecting 
		player_near_stove = true
		
# if any body exits the collision area of the stove this signal fires		
func _on_Stove_body_exited(body):
	# check to see if the body is the player
	if(body.get_name() == "Player"):
		player_near_stove = false
