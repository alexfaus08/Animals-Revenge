extends StaticBody2D

var player_near_mixing_station
var mixing
var item
var item_ready = false
var poison_type
var runtime 
onready var player = $"../../Player"
onready var t = get_node("MixingTimer")
onready var popup  = $"../../PoisonMenu"
export var simple_poison_percent = .25
export var simple_runtime = 10
export var better_poison_percent = .50
export var better_runtime = 15
export var killer_poison_percent = 1
export var killer_runtime = 25

func _ready():
	player_near_mixing_station = false
	mixing = false
	$MixSprite.play("Idle")

func _process(delta):
	if(player_near_mixing_station and not mixing and player.holding.size() > 0):
		if(player.holding.size() > 0):
			if(Input.is_action_just_pressed("ui_select") and typeof(player.holding[0]) != TYPE_STRING):
				popup.show()
	elif(player.holding.size() == 0 and player_near_mixing_station):
		if(Input.is_action_just_pressed("ui_select") and item_ready):
			player.add_object(item)
			item_ready = false
			$MixingDone.hide()
	if(not player_near_mixing_station):
		popup.hide()
			
	
func which_poison(percent):
	poison_type = percent
	if(percent == simple_poison_percent):
		runtime = simple_runtime
	elif(percent == better_poison_percent):
		runtime = better_runtime
	elif(percent == killer_poison_percent):
		runtime = killer_runtime
		
func poison():
	item = player.holding.pop_front()
	item.poison(poison_type)
	# the mixing station is now mixing
	mixing = true
	# play the mixing animation
	$MixSprite.play("Mix")
	# wait 10 seconds
	t.set_wait_time(runtime)
	# start the stove timer
	t.start()
	# wait until the timer completes it's wait time
	yield(t, "timeout")
	# mixing is over, go back to idle
	$MixSprite.play("Idle")
	mixing = false
	$MixingDone.show()
	$"MixingDone".play("ready")
	item_ready = true 


func _on_Area2D_body_entered(body):
	# check to see if that body is the player 
	if(body.get_name() == "Player"):
		player_near_mixing_station = true
	


func _on_Area2D_body_exited(body):
	if(body.get_name() == "Player"):
		player_near_mixing_station = false


