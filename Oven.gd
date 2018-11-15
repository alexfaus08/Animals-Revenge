extends StaticBody2D

var oven_contents = []
var oven_recipes = []
var recipe_ready = false
var recipe
var player_near_oven = false
var oven_off = true
onready var player = $"../../Player"
onready var screen_print =$"../../Bottom Box/TextPrint"
onready var world = $"../../../World"

func _ready():
	$OvenSprite.play("Idle")
	world._ready()
	# search for specifically stove recipes in all the recipes in the game
	for x in world.get_recipes():
		if(x.get_appliance() == "Oven"):
			oven_recipes.append(x.get_ingredients())

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
