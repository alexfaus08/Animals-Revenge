extends StaticBody2D

var player_near_trashcan = false
onready var player = $"../Player"
onready var screen_print = $"../Bottom Box/TextPrint"
var object
var obj_name
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _process(delta):
	
	if(player_near_trashcan and Input.is_action_just_pressed("ui_select") and player.holding.size() > 0):
		object = player.holding.pop_front()
		player.holding.clear()
		if(typeof(object) == TYPE_STRING):
			obj_name = object
		else:
			obj_name  = object.get_name()
		screen_print.append_bbcode("You have thrown away %s \n" % obj_name)
			
	


func _on_TrashCanArea_body_entered(body):
	if(body.get_name() == "Player"):
		player_near_trashcan = true


func _on_TrashCanArea_body_exited(body):
	if(body.get_name() == "Player"):
		player_near_trashcan = false
	
