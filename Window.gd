extends Area2D

# Stove.gd uses a very similiar layout. See Stove.gd for documentation.

onready var world = $"../../../World"
onready var popup = $"../../Order"
onready var turkey = $Turkey
onready var Recipe2 = $"../../Recipe2"
onready var Recipe3 = $"../../Recipe3"
onready var Recipe4 = $"../../Recipe4"
onready var slide1 = $"../../Recipe2/slide1"
onready var slide2 = $"../../Recipe3/slide2"
onready var slide3 = $"../../Recipe4/slide3"
#onready var animation = $"../../slide"
var recipe1 = false
var recipe2 = false
var recipe3 = false
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
		if(x.get_ingredients()[0] == "Turkey" or x.get_ingredients()[0] == "Chicken" or x.get_ingredients()[0] == "Ham"):
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
				Recipe2.play("Appear")			
				slide1.play("slide1")
				print(main_recipe.get_ingredients())
				print(side_recipe.get_ingredients())
				print("\n")
			elif(recipe1 == true and recipe2 == false):
				recipe2 = true
				Recipe3.show()
				Recipe3.play("Appear")			
				slide2.play("slide2")
				print(main_recipe.get_ingredients())
				print(side_recipe.get_ingredients())
				print("\n")
			elif(recipe1 == true and recipe2 == true and recipe3 == false):
				recipe3 = true
				Recipe4.show()
				Recipe4.play("Appear")			
				slide3.play("slide3")
				print(main_recipe.get_ingredients())
				print(side_recipe.get_ingredients())
				print("\n")
			elif(recipe1 == true and recipe2 == true and recipe3 == true):
				print("Backed up orders")
					
			
			
		#else:
			#print("too many orders on the counter")


func _on_Window_body_entered(body):
	if (body.get_name() == "Player"):
		player_near_window = true

	


func _on_Window_body_exited(body):
	if (body.get_name() == "Player"):
		player_near_window = false
		#Recipe2.hide()
