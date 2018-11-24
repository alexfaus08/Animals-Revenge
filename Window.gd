extends Area2D

# Stove.gd uses a very similiar layout. See Stove.gd for documentation.

onready var world = $"../../../World"
onready var popup = $"../../Order"
onready var Recipe2 = $"../../Recipe2"
onready var Recipe3 = $"../../Recipe3"
onready var Recipe4 = $"../../Recipe4"
onready var slide1 = $"../../Recipe2/slide1"
onready var slide2 = $"../../Recipe3/slide2"
onready var slide3 = $"../../Recipe4/slide3"
onready var player = $"../../Player"
onready var screenprint = $"../../Bottom Box/TextPrint"
onready var order_table = $"Order Table2" 


#onready var animation = $"../../slide"
var recipe1 = false
var recipe2 = false
var recipe3 = false
var recipe_ready = false
var order
var player_near_window
var dishes = []
var side_dishes = []
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
	if(player_near_window and player.holding.size() == 0):
		var main_recipe = _recipes_Main_Course()
		var side_recipe = _recipes_Sides()
		if(Input.is_action_just_pressed("ui_select")):
			if(recipe1 == false):
				recipe1 = true
				Recipe2.show()
				Recipe2.play("Appear")			
				slide1.play("slide1")
				print(main_recipe.get_ingredients())
				print(side_recipe.get_ingredients())
				order_table.waiting_orders.append(main_recipe)
				order_table.waiting_orders.append(side_recipe)
				print("\n")
			elif(recipe1 == true and recipe2 == false):
				recipe2 = true
				Recipe3.show()
				Recipe3.play("Appear")			
				slide2.play("slide2")
				print(main_recipe.get_ingredients())
				print(side_recipe.get_ingredients())
				order_table.waiting_orders.append(main_recipe)
				order_table.waiting_orders.append(side_recipe)
				print("\n")
			elif(recipe1 == true and recipe2 == true and recipe3 == false):
				recipe3 = true
				Recipe4.show()
				Recipe4.play("Appear")			
				slide3.play("slide3")
				print(main_recipe.get_ingredients())
				print(side_recipe.get_ingredients())
				order_table.waiting_orders.append(main_recipe)
				order_table.waiting_orders.append(side_recipe)
				print("\n")
			elif(recipe1 == true and recipe2 == true and recipe3 == true):
				print("Backed up orders")
				screenprint.append_bbcode("Backed up orders\n")
				order_table.waiting_orders.append(main_recipe)
				order_table.waiting_orders.append(side_recipe)
					
	elif(player_near_window and player.holding.size() > 0):
	
		# the order table is gonna need an array 
		# maybe 2 arrays? one for contents (items on the table)
		
		# another for orders waiting to be turned in 
		# if what the player is holding is not a string, it's a Recipe type
		
		if(typeof(player.holding[0]) != TYPE_STRING):
			# TODO: APPEND RECIPE TO ORDER TABLE
			for x in range(order_table.contents_on_table.size()):
				if player.holding[0] == order_table.contents_on_table[x]:
					print("items already on order table")
				else:
					order_table.contents_on_table.append(player.holding[0])
			# dont let the player append another main dish if there is already a main dish and same w/
			# side dishes
		
			# add the recipe to the table
			# update the order table sprite
			# if the order table has 2 objects:
				if(order_table.contents_on_table.size() >= 2):
					var matching_order = false
					for i in range(order_table.contents_on_table.size()):
						for x in range(order_table.waiting_orders.size()):
							if(i%2 ==0 and x%2 == 0):
								if(order_table.waiting_orders[x] == order_table.contents_on_table[i]):
									if(order_table.waiting_orders[x+1] == order_table.contents_on_table[i+1]):
										matching_order== true
					return matching_order					
				
				# check if the main and side dish match an order that is ready
					# if it is, complete that order, update score, (just make it an int for now), 
					# and have order table go back to having nothing on it 
			pass
			


func _on_Window_body_entered(body):
	if (body.get_name() == "Player"):
		player_near_window = true

func _on_Window_body_exited(body):
	if (body.get_name() == "Player"):
		player_near_window = false
		#Recipe2.hide()
