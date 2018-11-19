extends StaticBody2D

var top_oven_contents = []
var bottom_oven_contents = []
var oven_recipes = []
var recipe_ready = false
var recipe
var player_near_oven = false
var top_oven_off = true
var bottom_oven_off = true
var both_on = true
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
		if(player.holding.size() > 0):
			if(typeof(player.holding[0]) == TYPE_STRING):
			# is there an oven available?
				if(top_oven_off):
					top_oven_contents.append(player.holding.pop_front())
				elif(bottom_oven_off):
					bottom_oven_contents.append(player.holding.pop_front())
		# are they holding nothing?
			# is there an oven that has a recipe ready?
				# top oven has recipe ready:
					# grab recipe from top oven 
				# bottom has recipe:
					# get recipe
				# both ovens have recipe ready
					# ??????
					# have a pop up????
	# else if the player is near and click right click?
		# if there an oven that is off and has ingredients in it?
			# perhaps prompt, would you like to clear the contents of: Top Oven, Bottom Oven
	# running process to check what the ovens are doing
	top_oven_contents.sort()
	bottom_oven_contents.sort()
	# do any of the oven contents match a recipe?
	if(top_oven_contents in oven_recipes):
		# the top oven has a valid recipe
		recipe = world.recipe_lookup(top_oven_contents)
		top_timer.set_wait_time(recipe.get_cook_time())
		top_timer.start()
		top_oven_off = false
	elif(bottom_oven_contents in oven_recipes):
		recipe = world.recipe_lookup(bottom_oven_contents)
		bottom_timer.set_wait_time(recipe.get_cook_time())
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



func _on_Top_Oven_Timer_timeout():
	top_oven_off = true
	recipe = world.recipe_lookup(top_oven_contents)
	top_oven_contents.clear()
	top_oven_contents.append(recipe)
	# add the recipe to the top oven contents and make it retrievable 
	# play the Oven Ready animation


func _on_Bottom_Oven_Timer_timeout():
	bottom_oven_off = true
	recipe = world.recipe_lookup(bottom_oven_contents)
	bottom_oven_contents.clear()
	bottom_oven_contents.append(recipe)
	# add the recipe to the top oven contents and make it retrievable 
	# play the Oven Ready animation

func _on_Area2D_body_entered(body):
	# check to see if that body is the player 
	if(body.get_name() == "Player"):
		# set player near stove to true because they are intersecting 
		player_near_oven = true
