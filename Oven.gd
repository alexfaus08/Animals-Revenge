extends StaticBody2D

var oven_contents = []
var oven_recipes = []
var recipe_ready = false
var recipe
var player_near_oven = false
var oven_top_off = true
var oven_bottom_off = true
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
	if(player_near_oven and Input.is_action_just_pressed("ui_select")):
		if(player.holding.size() > 0 and (oven_top_off or oven_bottom_off)):
			oven_contents.append(player.holding.pop_front())
			oven_contents.sort()
			if(oven_contents in oven_recipes):
				recipe = world.recipe_lookup(oven_contents)
				if(oven_top_off):
					oven_top_off = false
					cook("top", recipe)
					oven_top_off = true
				elif(oven_bottom_off):
					oven_bottom_off = false
					cook("bottom", recipe)
					oven_bottom_off = true
		elif(recipe_ready):
			player.add_object(oven_contents.pop_front())
	elif(player_near_oven and Input.is_action_just_pressed("right_click")):
		oven_contents.clear()
			
func cook(oven, recipe):
	if(oven == "top"):
		$OvenSprite.play("Cook Top")
		#TODO: cook in top oven
		pass
	else:
		#TODO: cook in bottom oven
		pass

# TODO:
	# figure out how to get the bottom and top animations to overlap
	# cook the recipe
	# have the recipe returnable to the user
