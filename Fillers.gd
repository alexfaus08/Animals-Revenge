extends Node2D

var one
var two
var three 
var four 
onready var player = $"../../Player"
var player_near_counters


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func player_holding_something():
	if(player.holding.size() > 0):
		return true
	else:
		return false

func _on_1_pressed():
	if(player_holding_something() and player_near_counters):
		one = player.holding.pop_front()
		$"1".hide()
		$"f1".show()
		var obj_name
		if(typeof(one) == TYPE_STRING):
			obj_name = one
		else:
			if(one.is_poisoned()):
				obj_name = "[color=red]Poisoned[/color] %s" % one.get_name() 
			else:
				obj_name  = one.get_name()
		$"f1".set_tooltip(obj_name)


func _on_2_pressed():
	if(player_holding_something() and player_near_counters):
		two = player.holding.pop_front()
		$"2".hide()
		$"f2".show()
		var obj_name
		if(typeof(two) == TYPE_STRING):
			obj_name = two
		else:
			if(two.is_poistwod()):
				obj_name = "[color=red]Poistwod[/color] %s" % two.get_name() 
			else:
				obj_name  = two.get_name()
		$"f2".set_tooltip(obj_name)


func _on_3_pressed():
	if(player_holding_something() and player_near_counters):
		three = player.holding.pop_front()
		$"3".hide()
		$"f3".show()
		var obj_name
		if(typeof(three) == TYPE_STRING):
			obj_name = three
		else:
			if(three.is_poisoned()):
				obj_name = "[color=red]Poisoned[/color] %s" % three.get_name() 
			else:
				obj_name  = three.get_name()
		$"f3".set_tooltip(obj_name)


func _on_4_pressed():
	if(player_holding_something() and player_near_counters):
		four = player.holding.pop_front()
		$"4".hide()
		$"f4".show()
		var obj_name
		if(typeof(four) == TYPE_STRING):
			obj_name = four
		else:
			if(four.is_poisoined()):
				obj_name = "[color=red]Poisoined[/color] %s" % four.get_name() 
			else:
				obj_name  = four.get_name()
		$"f4".set_tooltip(obj_name)


func _on_f1_pressed():
	if(not player_holding_something() and player_near_counters):
		player.add_object(one)
		$"f1".hide()
		$"1".show()


func _on_f2_pressed():
	if(not player_holding_something() and player_near_counters):
		player.add_object(two)
		$"f2".hide()
		$"2".show()


func _on_f3_pressed():
	if(not player_holding_something() and player_near_counters):
		player.add_object(three)
		$"f3".hide()
		$"3".show()


func _on_f4_pressed():
	if(not player_holding_something() and player_near_counters):
		player.add_object(four)
		$"f4".hide()
		$"4".show()


func _on_Area2D_body_entered(body):
	if(body.get_name() == "Player"):
		player_near_counters = true


func _on_Area2D_body_exited(body):
	if(body.get_name() == "Player"):
		player_near_counters = false

