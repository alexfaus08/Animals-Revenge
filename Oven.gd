extends StaticBody2D

var top_oven_contents = []
var bottom_oven_contents = []
var oven_recipes = []
var recipe_ready = false
var recipe
var player_near_oven = false
var oven_top_off = true
var oven_bottom_off = true
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
	pass
	# is the player near the oven and did they click left click? 
		# are they holding an ingredient?
			# is there an oven available?
				# put ingredient in available oven
				# start the timer
	# else if the player is near and click right click?
		# if there an oven that is off and has ingredients in it?
			# perhaps prompt, would you like to clear the contents of: Top Oven, Bottom Oven
	# running process to check what the ovens are doing
		# Which timers are running?
			# both timers running?
				# play both animations
			# top timer running?
				# play top animation
			# bottom timer running?
				# player bottom animation



func _on_Top_Oven_Timer_timeout():
	oven_top_off = true
	# add the recipe to the top oven contents and make it retrievable 


func _on_Bottom_Oven_Timer_timeout():
	oven_bottom_off = true
