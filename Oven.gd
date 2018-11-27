extends StaticBody2D

var top_oven_contents = []
var bottom_oven_contents = []
var oven_recipes = []
var top_recipe_ready = false
var bottom_recipe_ready = false
var bottom_recipe
var top_recipe
var player_near_oven = false
var top_oven_off = true
var bottom_oven_off = true
onready var top_timer = $"Top Oven Timer"
onready var bottom_timer = $"Bottom Oven Timer"
onready var player = $"../../Player"
onready var screen_print =$"../../Bottom Box/TextPrint"
onready var world = $"../../../World"
var oven = "top"

func _ready():
	$OvenSprite.play("Idle")
	# search for specifically stove recipes in all the recipes in the game
	for x in world.get_recipes():
		if(x.get_appliance() == "Oven"):
			oven_recipes.append(x.get_ingredients())
	
func _process(delta):
	# is the player near the oven and did they click left click? 
	if(player_near_oven and Input.is_action_just_pressed("ui_select")):
		# are they holding an ingredient?
		$"Control/OvenPopUp".show()
	if(not player_near_oven):
		$"Control/OvenPopUp".hide()
	if(top_recipe_ready or bottom_recipe_ready):
		$OvenReady.show()
		$OvenReady.play("ready")
	# running process to check what the ovens are doing
	top_oven_contents.sort()
	bottom_oven_contents.sort()
	# do any of the oven contents match a recipe?
	if(top_oven_contents in oven_recipes and top_oven_off and not top_recipe_ready):
		# the top oven has a valid recipe
		top_recipe = world.recipe_lookup(top_oven_contents)
		top_timer.set_wait_time(top_recipe.get_cook_time())
		top_timer.start()
		top_oven_off = false
	elif(bottom_oven_contents in oven_recipes and bottom_oven_off and not bottom_recipe_ready):
		bottom_recipe = world.recipe_lookup(bottom_oven_contents)
		bottom_timer.set_wait_time(bottom_recipe.get_cook_time())
		bottom_timer.start()
		bottom_oven_off = false
	# Which timers are running?
	if(not top_timer.is_stopped() and not bottom_timer.is_stopped()):
		# both timers are running
		# play both animations
		$OvenSprite.play("Both Cooking")
	elif(not top_timer.is_stopped()):
		# top timer running
		$OvenSprite.play("Top Cooking")
	
	elif(not bottom_timer.is_stopped()):
		# bottom timer running
		$OvenSprite.play("Bottom Cooking")
	
	elif(top_oven_off and bottom_oven_off):
		$OvenSprite.play("Idle")



func _on_Top_Oven_Timer_timeout():
	print("DONE")
	top_recipe_ready = true
	top_oven_off = true
	top_recipe = world.recipe_lookup(top_oven_contents)
	top_oven_contents.clear()
	top_oven_contents.append(top_recipe)
	$OvenReady.show()
	$OvenReady.play("ready")
	top_timer.stop()
	# add the recipe to the top oven contents and make it retrievable 
	# play the Oven Ready animation


func _on_Bottom_Oven_Timer_timeout():
	print("DONE")
	bottom_oven_off = true
	bottom_recipe_ready = true
	bottom_recipe = world.recipe_lookup(bottom_oven_contents)
	bottom_oven_contents.clear()
	bottom_oven_contents.append(bottom_recipe)
	$OvenReady.show()
	$OvenReady.play("ready")
	bottom_timer.stop()
	# add the recipe to the top oven contents and make it retrievable 
	# play the Oven Ready animation

func _on_Area2D_body_entered(body):
	# check to see if that body is the player 
	if(body.get_name() == "Player"):
		# set player near stove to true because they are intersecting 
		player_near_oven = true


func _on_Area2D_body_exited(body):
	# check to see if that body is the player 
	if(body.get_name() == "Player"):
		player_near_oven = false


func _on_Top_pressed():
	if(player.holding.size() > 0):
			if(typeof(player.holding[0]) == TYPE_STRING):
				if(top_oven_off):
					top_oven_contents.append(player.holding.pop_front())
	elif(top_recipe_ready and player.holding.size() == 0):
		top_oven_contents.clear()
		player.add_object(top_recipe)
		top_recipe_ready = false
		$OvenReady.hide()
	elif(not top_oven_off):
		screen_print.append_bbcode("[color=red]The top oven is still cooking.[/color]\n")
	$"Control/OvenPopUp".hide()
		


func _on_Bottom_pressed():
	if(player.holding.size() > 0):
			if(typeof(player.holding[0]) == TYPE_STRING):
				if(bottom_oven_off):
					bottom_oven_contents.append(player.holding.pop_front())
	elif(bottom_recipe_ready and player.holding.size() == 0):
		bottom_oven_contents.clear()
		player.add_object(bottom_recipe)
		bottom_recipe_ready = false
		$OvenReady.hide()
	elif(not bottom_oven_off):
		screen_print.append_bbcode("[color=red]The bottom oven is still cooking.[/color]\n")
	$"Control/OvenPopUp".hide()
	
