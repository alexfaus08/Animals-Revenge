extends Area2D

# Stove.gd uses a very similiar layout. See Stove.gd for documentation.

onready var world = $"../../../World"
onready var Recipe2 = $"../../Recipe2"
onready var Recipe3 = $"../../Recipe3"
onready var Recipe4 = $"../../Recipe4"
onready var slide1 = $"../../Recipe2/slide1"
onready var slide2 = $"../../Recipe3/slide2"
onready var slide3 = $"../../Recipe4/slide3"
onready var player = $"../../Player"
onready var screenprint = $"../../Bottom Box/TextPrint"
var main1
var side1
var m1
var s1
var m2
var s2
var m3
var s3

#onready var animation = $"../../slide"
var recipe1 = false
var recipe2 = false
var recipe3 = false
var order
var player_near_window = false
var dishes = []
var main_turnin = []
var side_turnin = []
var side_dishes = []
var player_near_turnin = false
#var diag = AcceptDialog.new()

func _ready():
	Recipe2.hide()
	Recipe3.hide()
	Recipe4.hide()
	player_near_window = false
	world._ready()
	for x in world.get_recipes():
		if(x.get_ingredients()[0] == "Raw Turkey" or x.get_ingredients()[0] == "Raw Chicken" or x.get_ingredients()[0] == "Raw Ham"):
			dishes.append(x)
		else:
			side_dishes.append(x)
	
func _recipes_Main_Course():
	#randomly pick a dish
	var dish_number = randi()%3
	#return the dish
	return dishes[dish_number]

#List ot side dishes	
func _recipes_Sides():
	#randomly pick a side
	var side_dish_number = randi()%4
	#return the side dish
	return side_dishes[side_dish_number]
	

func _process(delta):
	if(player_near_window):
		var main_recipe = _recipes_Main_Course()
		var side_recipe = _recipes_Sides()
		if(Input.is_action_just_pressed("ui_select")):
			if(recipe1 == false):
				recipe1 = true
				Recipe2.show()
				Recipe2.set_main(main_recipe)
				Recipe2.set_side(side_recipe)
				print(main_recipe.get_ingredients())
				print(side_recipe.get_ingredients())
				print("\n")
				$"../../Recipe2/rt1".start()
			elif(recipe1 == true and recipe2 == false):
				recipe2 = true
				Recipe3.show()
				Recipe3.set_main(main_recipe)
				Recipe3.set_side(side_recipe)
				print(main_recipe.get_ingredients())
				print(side_recipe.get_ingredients())
				print("\n")
				$"../../Recipe3/rt2".start()
			elif(recipe1 == true and recipe2 == true and recipe3 == false):
				recipe3 = true
				Recipe4.show()
				Recipe4.set_main(main_recipe)
				Recipe4.set_side(side_recipe)
				print(main_recipe.get_ingredients())
				print(side_recipe.get_ingredients())
				print("\n")
				$"../../Recipe4/rt3".start()
			elif(recipe1 == true and recipe2 == true and recipe3 == true):
				print("Backed up orders")
				screenprint.append_bbcode("Backed up orders\n")
					
	elif(player_near_turnin and player.holding.size() > 0):
		if(Input.is_action_just_pressed("ui_select")):
			# the order table is gonna need an array 
			# maybe 2 arrays? one for contents (items on the table)
			# another for orders waiting to be turned in 
			# if what the player is holding is not a string, it's a Recipe type
			if(typeof(player.holding[0]) != TYPE_STRING):
				if(player.holding[0].get_name() == "Turkey" or player.holding[0].get_name() == "Chicken" or player.holding[0].get_name() == "Ham"):
					if(main_turnin.size() == 0):
						main_turnin.append(player.holding.pop_front())
						screenprint.append_bbcode("You have turned in the main dish: %s \n" % screenprint.get_object_name(main_turnin.front()))
						if(main_turnin.front().is_poisoned()):
							$"../main".play("poison")
						else:
							$"../main".play("filled")
				else:
					if(side_turnin.size() == 0):
						side_turnin.append(player.holding.pop_front())
						screenprint.append_bbcode("You have turned in the main dish: %s \n" % screenprint.get_object_name(main_turnin.front()))
						if(side_turnin.front().is_poisoned()):
							$"../side".play("poison")
						else:
							$"../side".play("filled")
	if(player_near_turnin):
		if(Input.is_action_just_pressed("right_click")):
			main_turnin.clear()
			side_turnin.clear()
			$"../main".play("idle")
			$"../side".play("idle")
					
	
	if(main_turnin.size() == 1 and side_turnin.size() == 1):

		if(recipe1 and (main_turnin.size() == 1 and side_turnin.size() == 1)):
			if(main_turnin.front().get_name() == Recipe2.get_main().get_name() and side_turnin.front().get_name() == Recipe2.get_side().get_name() and recipe1):
				cash_out()
				recipe1 = false
				Recipe2.hide()
				$"../../Recipe2/rt1".stop()
				score(main_turnin.front(), side_turnin.front())
		if(recipe2 and (main_turnin.size() == 1 and side_turnin.size() == 1)):
			if(main_turnin.front().get_name() == Recipe3.get_main().get_name() and side_turnin.front().get_name() == Recipe3.get_side().get_name() and recipe2):
				cash_out()
				recipe2 = false
				Recipe3.hide()
				$"../../Recipe3/rt2".stop()
				score(main_turnin.front(), side_turnin.front())
		if(recipe3 and (main_turnin.size() == 1 and side_turnin.size() == 1)):
			if(main_turnin.front().get_name() == Recipe4.get_main().get_name() and side_turnin.front().get_name() == Recipe4.get_side().get_name() and recipe3):
				cash_out()
				recipe3 = false
				Recipe4.hide()
				score(main_turnin.front(), side_turnin.front())
				$"../../Recipe4/rt3".stop()
		
		#TODO: if two recipes match, choose the one with the least time left of the timer
		main_turnin.clear()
		side_turnin.clear()

func score(main, side):
	var score = 10
	var kills = 0
	var stringg
	if(main.is_poisoned()):
		if(main.get_poison() == 1):
			score += 5
			kills+=1
		else:
			if(poison_roll(main.get_poison())):
				score += 5
				kills+=1
	elif(side.is_poisoned()):
		if(side.get_poison() == 1):
			score += 5
			kills += 1
		else:
			if(poison_roll(side.get_poison())):
				score += 5
				kills += 1
	stringg = "Order complete. You got %s kill(s) for %s points.\n" % [str(kills), str(score)]
	screenprint.append_bbcode(stringg)
	$"../../Sidebar".updatescore(score)
	return score
	

func _on_Window_body_entered(body):
	if (body.get_name() == "Player"):
		player_near_window = true

func _on_Window_body_exited(body):
	if (body.get_name() == "Player"):
		player_near_window = false
		#Recipe2.hide()


func _on_Turn_In_body_entered(body):
	if (body.get_name() == "Player"):
		player_near_turnin = true

func _on_Turn_In_body_exited(body):
	if (body.get_name() == "Player"):
		player_near_turnin = false
		
func poison_roll(percent):
	var roll
	# roll a 4 sided die
	roll = randi()%5+1
	if(percent == .25):
		if(roll == 1):
			return true
	elif(percent == .50):
		if(roll == 1 or roll == 2):
			return true
	return false

func cash_out():
	$"../main".play("idle")
	$"../side".play("idle")
	$"../Cash Out".show()
	$"../Cash Out".play("default")
	var t = Timer.new()
	t.set_wait_time(2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	$"../Cash Out".hide()
	
	

func _on_rt1_timeout():
	recipe1 = false
	$"../../Sidebar".updatescore(-5)
	$"../../Recipe2".hide()


func _on_rt2_timeout():
	recipe2 = false
	$"../../Sidebar".updatescore(-5)
	$"../../Recipe3".hide()


func _on_rt3_timeout():
	recipe3 = false
	$"../../Sidebar".updatescore(-5)
	$"../../Recipe4".hide()
