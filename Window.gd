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
	var side_dish_number = randi()%5
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
			elif(recipe1 == true and recipe2 == false):
				recipe2 = true
				Recipe3.show()
				Recipe3.set_main(main_recipe)
				Recipe3.set_side(side_recipe)
				print(main_recipe.get_ingredients())
				print(side_recipe.get_ingredients())
				print("\n")
			elif(recipe1 == true and recipe2 == true and recipe3 == false):
				recipe3 = true
				Recipe4.show()
				Recipe4.set_main(main_recipe)
				Recipe4.set_side(side_recipe)
				print(main_recipe.get_ingredients())
				print(side_recipe.get_ingredients())
				print("\n")
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
				if(player.holding[0] in dishes):
					if(main_turnin.size() == 0):
						main_turnin.append(player.holding.pop_front())
						$"../main".play("filled")
				elif(player.holding[0] in side_dishes):
					if(side_turnin.size() == 0):
						side_turnin.append(player.holding.pop_front())
						$"../side".play("filled")
		elif(player_near_turnin and player.holding.size() == 0):
				# have a popup that allows the player to grab a dish or destroy contents
				pass
	
	if(main_turnin.size() == 1 and side_turnin.size() == 1):
		# check to see if an order is ready to be completed
		# Recipe2?
		if(main_turnin.front().get_name() == Recipe2.get_main().get_name() and side_turnin.front().get_name() == Recipe2.get_side().get_name()):
			$"../main".play("cash out")
			$"../side".play("cash out")

		elif(main_turnin.front().get_name() == Recipe3.get_main().get_name() and side_turnin.front().get_name() == Recipe3.get_side().get_name()):
			$"../main".play("cash out")
			$"../side".play("cash out")

		if(main_turnin.front().get_name() == Recipe4.get_main().get_name() and side_turnin.front().get_name() == Recipe4.get_side().get_name()):
			$"../main".play("cash out")
			$"../side".play("cash out")

func score(main, side):
	var score = 0
	if(main.is_poisoned()):
		pass
	else:
		score += 10
	if(side.is_poisoned()):
		pass
	else:
		score += 10
	

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
